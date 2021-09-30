import 'package:EfendimDriverApp/core/preference/preference.dart';
import 'package:EfendimDriverApp/ui/Auth/Verification/UI/verification_page.dart';
import 'package:EfendimDriverApp/ui/Auth/Verification/UI/verify_otp.dart';
import 'package:EfendimDriverApp/ui/Auth/alternative_button.dart';
import 'package:EfendimDriverApp/ui/Auth/custom_page.dart';
import 'package:EfendimDriverApp/ui/Components/alternative_text_field.dart';
import 'package:EfendimDriverApp/ui/Components/help_text.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:base_notifier/base_notifier.dart';
import 'package:EfendimDriverApp/core/api/api.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:EfendimDriverApp/ui/Auth/MobileNumber/model/phone_number_model.dart';
import 'package:EfendimDriverApp/ui/Locale/locales.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:EfendimDriverApp/ui/Components/entry_field.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:ui_utils/ui_utils.dart';
import 'package:EfendimDriverApp/core/localizations/global_translations.dart';
import 'package:url_launcher/url_launcher.dart';

//first page that takes phone number as input for verification
class PhoneNumber1 extends StatefulWidget {
  static const String id = 'phone_number';

  @override
  _PhoneNumberState1 createState() => _PhoneNumberState1();
}

class _PhoneNumberState1 extends State<PhoneNumber1> {
  final TextEditingController _controller = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  SmsAutoFill autoFill = SmsAutoFill();

  String isoCode = '+90';
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool agree = true;

  var enabledTermsCondition = 1;

  void _showSnackBar(String text) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      backgroundColor: Get.theme.primaryColor,
      content: Text(text),
      duration: const Duration(seconds: 1),
    ));
  }

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
              key: _scaffoldKey,
              body: CustomPage(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Spacer(),
                        TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                          ),
                          onPressed: () {
                            // Get.offAll(() => ControlView());
                          },
                          child: Text(
                            lang.translate(""),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Card(
                      margin: EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              "assets/images/logo-sm.png",
                              scale: 2,
                              fit: BoxFit.fitWidth,
                              width: 160,
                            ),
                            SizedBox(height: 16.0),
                            Text(
                              lang.translate("Welcome"),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 16.0),
                            Text(
                              lang.translate("Log in using your mobile number"),
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(height: 16.0),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () async {
                                      String phone =
                                          _controller.text.replaceAll(" ", "");
                                      if (phone.startsWith("0")) {
                                        phone = phone.substring(1);
                                      }
                                    },
                                    child: AlternativeTextField(
                                      controller: _controller,
                                      hint: lang.translate("Mobile"),
                                      keyboardType: TextInputType.phone,
                                      isPhoneNumber: true,
                                      isAutoFill: true,
                                      prefix: Directionality(
                                        child: CountryCodePicker(
                                          onChanged: (country) {
                                            isoCode = country.dialCode;
                                          },
                                          onInit: (value) {
                                            isoCode = value.dialCode;
                                          },
                                          initialSelection: '+90',
                                          //controller.countryCode,
                                          favorite: ['+90', 'TR'],
                                          showCountryOnly: false,
                                          showOnlyCountryWhenClosed: false,
                                          alignLeft: false,
                                          padding: EdgeInsets.all(4),
                                          flagWidth: 18,
                                          textStyle: TextStyle(
                                            letterSpacing: .23,
                                            fontSize: 16.0,
                                            locale: Locale('en'),
                                          ),
                                        ),
                                        textDirection: TextDirection.ltr,
                                      ),
                                      autoFill: () async {
                                        print(isoCode);

                                        String autoFilPhone =
                                            await model.autoFill.hint;
                                        print(autoFilPhone);
                                        if (autoFilPhone != null) {
                                          print("notnull");

                                          isoCode = "";
                                          _controller.text = autoFilPhone;
                                          //.substring(isoCode.length,
                                          //);
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            //  int enabledTermsCondition = 1;
                            // lang.settings["signup_settings"]["enabled_terms_condition"];

                            Column(
                              children: [
                                if (enabledTermsCondition == 1)
                                  Row(
                                    children: <Widget>[
                                      Checkbox(
                                        value: agree,
                                        onChanged: (value) {
                                          setState(() {
                                            agree = value;
                                          });
                                        },
                                      ),
                                      Row(
                                        children: [
                                          Wrap(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  //  controller.phoneAddressFocus
                                                  //   .unfocus();
                                                },
                                                child: Text(
                                                  lang.translate(
                                                      "Agree to the"),
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  String url = "";
                                                  // lang.settings["signup_settings"]["terms_url"];
                                                  // if (await canLaunch(url)) {
                                                  await launch(url);
                                                  // }
                                                },
                                                child: Text(
                                                  lang.translate(
                                                      "Terms and conditions"),
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 12),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                model.busy
                                    ? Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      )
                                    : AlternativeButton(
                                        label: lang.translate("Continue"),
                                        onPressed: () {
                                          if (_controller.text.isEmpty) {
                                            _showSnackBar(lang.translate(
                                                'Phone number is required'));
                                          } else if (!agree) {
                                            _showSnackBar(lang.translate(
                                                'Please accept terms and conditions'));
                                          } else {
                                            print('okkk');
                                            model.setBusy();
                                            startPhoneAuth(
                                                context,
                                                isoCode + _controller.text,
                                                model);
                                            // navigateToVeriifcation(context, 'mobileNumber','',model);

                                          }

                                          _checkconnectivity();
                                        }
                                        //  controller.handleLogin();

                                        ),
                              ],
                            ),
                            //   }),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                lang.translate('will_send_a_sms'),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.sourceSansPro(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  lang.translate('make_sure_you_have_entered'),
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.sourceSansPro(
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    HelpText(
                      text: lang.translate('Need Help?'),
                    ),
                  ],
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
    model.setBusy();
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
              await Preference.setString(PrefKeys.userPassword, user.uid);

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
      /* codeSent: (String verificationId, int resendToken) {
        model.setIdle();
        UI.toast("code sent");
        navigateToVeriifcation(context, mobileNumber, verificationId, model);
      },*/

      codeSent: (String verificationId, int resendToken) {
        Get.back();
        print("hello from code ");
        navigateToVeriifcation(
            context, isoCode, _controller.text, verificationId, model);

        //  Get.to(() => VerifyOtp(
        //      countryCode: isoCode,
        //    phone: _controller.text,
        //  verificationID: verificationId,
        //));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        model.setIdle();
      },
    );
  }

  loginApi(PhoneNumberPageModel model, String token) async {
    model.signin(phoneNumber: isoCode + _controller.text, token: token);
  }

  navigateToVeriifcation(BuildContext context, String isocode, String mobile,
      String code, PhoneNumberPageModel model) async {
    String result = await Navigator.of(context).push(
      MaterialPageRoute<String>(builder: (context) {
        return VerifyOtp(
          countryCode: isocode,
          phone: mobile,
          verificationID: code,
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
