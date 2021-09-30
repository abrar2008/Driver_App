import 'package:EfendimDriverApp/core/preference/preference.dart';
import 'package:EfendimDriverApp/ui/Auth/Verification/UI/verification_page.dart';
import 'package:EfendimDriverApp/ui/Components/help_text.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:base_notifier/base_notifier.dart';
import 'package:EfendimDriverApp/core/api/api.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:EfendimDriverApp/ui/Auth/MobileNumber/model/phone_number_model.dart';
import 'package:EfendimDriverApp/ui/Locale/locales.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:EfendimDriverApp/ui/Components/entry_field.dart';
import 'package:ui_utils/ui_utils.dart';
import 'package:EfendimDriverApp/core/localizations/global_translations.dart';

//first page that takes phone number as input for verification
class PhoneNumber extends StatefulWidget {
  static const String id = 'phone_number';

  @override
  _PhoneNumberState createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
  final TextEditingController _controller = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  String isoCode = '+90';

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return FocusWidget(
      child: BaseWidget<PhoneNumberPageModel>(
          model: PhoneNumberPageModel(
              api: Provider.of<Api>(context),
              context: context,
              auth: Provider.of(context)),
          builder: (context, model, child) {
            final lang =
                Provider.of<GlobalTranslations>(context, listen: false);
            return Scaffold(
              body: SingleChildScrollView(
                child: Container(
                  height: ScreenUtil.screenHeightDp,
                  width: ScreenUtil.screenWidthDp,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                      ),
                      // Image.asset(
                      //   "assets/images/logo_delivery.png",
                      //   scale: 4, //delivoo logo
                      // ),
                      Lottie.asset('assets/animation/main.json',
                          fit: BoxFit.cover),
                      // Image.asset(
                      //   "assets/images/login_delivery.png",
                      // scale: 3,
                      //   fit: BoxFit.cover,
                      // ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            lang.translate("Delivering almost"),
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                      // Image.asset(
                      //   "assets/images/logo_delivery.png",
                      //   scale: 4, //delivoo logo
                      // ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            lang.translate("Everything"),
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                      Spacer(),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: mobileInput(context, model),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget mobileInput(BuildContext context, PhoneNumberPageModel model) {
    GlobalTranslations lang = GlobalTranslations();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IntlPhoneField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: lang.translate("Mobile Number"),
              border: OutlineInputBorder(
                borderSide: BorderSide(),
              ),
            ),
            initialCountryCode: 'TR',
            onChanged: (phone) {
              isoCode = phone.countryCode;
              print(isoCode);
            },
          ),
        ),

        // if phone number is valid, button gets enabled and takes to register screen
        model.busy
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: RaisedButton(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 12.0),
                    child: Text(
                      lang.translate("Continue"),
                      style: Theme.of(context).textTheme.button,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  onPressed: () {
                    if (_controller.text.isEmpty)
                      UI.toast("Mobile number is required");
                    else {
                      model.setBusy();
                      startPhoneAuth(
                          context, isoCode + _controller.text, model);
                      // navigateToVeriifcation(context, 'mobileNumber','',model);

                    }

                    _checkconnectivity();
                  },
                ),
              ),

        HelpText(text: 'Need help?'),

        // Row(
        //   children: <Widget>[
        //     countryCodePicker(context),
        //     SizedBox(
        //       width: 10.0,
        //     ),
        //     //takes phone number as input
        //     Expanded(
        //       child: EntryField(
        //         controller: _controller,
        //         keyboardType: TextInputType.number,
        //         readOnly: false,
        //         hint: AppLocalizations.of(context).mobileText,
        //         border: OutlineInputBorder(),
        //         // maxLength: 10,
        //         // border: InputBorder(),
        //       ),
        //     ),
        //   ],
        // ),

        // EntryField(
        //     controller: _passwordController,
        //     keyboardType: TextInputType.number,
        //     readOnly: false,
        //     secure: true,
        //     maxLines: 1,
        //     border: OutlineInputBorder(),
        //     label: lang.translate("sign password"),
        //     hint: lang.translate("sign password")
        //     // maxLength: 10,
        //     // border: InputBorder.none,
        //     ),
      ],
    );
  }

  startPhoneAuth(BuildContext context, String mobileNumber,
      PhoneNumberPageModel model) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: mobileNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
// ANDROID ONLY!

        model.setIdle();
        // Sign the user in (or link) with the auto-generated credential

        // await FirebaseAuth.instance.signInWithCredential(credential);

        if (credential != null) {
          UserCredential userCredential =
              await FirebaseAuth.instance.signInWithCredential(credential);

          if (userCredential != null) {
            User user = userCredential.user;
            String userToken = await user.getIdToken(true);
            if (user != null) {
              Preference.setString(PrefKeys.userPassword, user.uid);

              loginApi(model, user.uid);
            }
          }
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        model.setIdle();
        if (e.code == 'invalid-phone-number') {
          // print('The provided phone number is not valid.');
          // showMessage(lang.translate("invalid mobile number"));
          UI.toast("invalid mobile number");
        }
      },
      codeSent: (String verificationId, int resendToken) {
        model.setIdle();
        UI.toast("code sent");
        navigateToVeriifcation(context, mobileNumber, verificationId, model);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        model.setIdle();
      },
    );
  }

  loginApi(PhoneNumberPageModel model, String token) async {
    model.signin(phoneNumber: isoCode + _controller.text, token: token);
  }

  navigateToVeriifcation(BuildContext context, String mobile, String code,
      PhoneNumberPageModel model) async {
    String result = await Navigator.of(context).push(
      MaterialPageRoute<String>(builder: (context) {
        return VerificationPage(
          mobile,
          code,
        );
      }),
    );

    if (result != null && result.length > 0) {
      loginApi(model, result);
    } else {
      model.setIdle();
    }
  }

  CountryCodePicker countryCodePicker(BuildContext context) {
    return CountryCodePicker(
      onChanged: (value) {
        isoCode = value.dialCode;
      },
      builder: (value) => buildButton(context, value),
      initialSelection: '+90',
      textStyle: Theme.of(context).textTheme.caption,
      showFlag: false,
      showFlagDialog: true,
      favorite: ['+91', 'US'],
      showDropDownButton: true,
    );
  }

  buildButton(BuildContext context, CountryCode isoCode) {
    return Row(
      children: <Widget>[
        Text(
          '$isoCode',
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
  }

  _checkconnectivity() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      _showDialogue("No internet", "You are not connected to internet");
    }
    //  else if (result == ConnectivityResult.mobile) {
    //   _showdialogue("internet", "Connected to wifi");
    // } else if (result == ConnectivityResult.wifi) {
    //   _showdialogue("internet", "Connected to wifi");
    // }
  }

  _showDialogue(title, text) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(text),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("ok"))
            ],
          );
        });
  }
}
