import 'dart:async';
import 'package:EfendimDriverApp/core/preference/preference.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:EfendimDriverApp/ui/Components/bottom_bar.dart';
import 'package:EfendimDriverApp/ui/Components/entry_field.dart';
import 'package:EfendimDriverApp/ui/Locale/locales.dart';
import 'package:EfendimDriverApp/ui/Themes/colors.dart';
import 'package:ui_utils/ui_utils.dart';

//Verification page that sends otp to the phone number entered on phone number page
class VerificationPage extends StatelessWidget {
  final String mobileNumber;
  final String verificationCode;

  VerificationPage(this.mobileNumber, this.verificationCode);

  AppLocalizations appLocalizations;
  @override
  Widget build(BuildContext context) {
    appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          AppLocalizations.of(context).verification,
          style: Theme.of(context).textTheme.caption.copyWith(fontSize: 16.7),
        ),
      ),
      body: OtpVerify(mobileNumber, verificationCode),
    );
  }
}

//otp verification class
class OtpVerify extends StatefulWidget {
  final String mobileNumber;
  final String verificationCode;

  OtpVerify(this.mobileNumber, this.verificationCode);

  @override
  _OtpVerifyState createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {
  final TextEditingController _controller = TextEditingController();

  // VerificationBloc _verificationBloc;
  bool isDialogShowing = false;
  int _counter = 20;
  Timer _timer;

  _startTimer() {
    //shows timer
    _counter = 90; //time counter

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _counter > 0 ? _counter-- : _timer.cancel();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    verifyPhoneNumber();
  }

  void verifyPhoneNumber() {
    //verify phone number method using otp
    _startTimer();
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Divider(
          color: Theme.of(context).cardColor,
          thickness: 8.0,
        ),
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            AppLocalizations.of(context).enterVerification,
            style: Theme.of(context).textTheme.headline6.copyWith(
                fontSize: 22, color: Theme.of(context).secondaryHeaderColor),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: EntryField(
            controller: _controller,
            readOnly: false,
            label: AppLocalizations.of(context).verificationCode,
            maxLength: 6,
            keyboardType: TextInputType.number,
            // initialValue: '',
          ),
        ),
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '$_counter sec',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            FlatButton(
                shape: RoundedRectangleBorder(side: BorderSide.none),
                padding: EdgeInsets.all(24.0),
                disabledTextColor: kDisabledColor,
                textColor: kMainColor,
                child: Text(
                  AppLocalizations.of(context).resend,
                  style: TextStyle(
                    fontSize: 16.7,
                    color: kMainColor,
                  ),
                ),
                onPressed: _counter < 1
                    ? () {
                        // verifyPhoneNumber();
                        startPhoneAuth(context, widget.mobileNumber);
                      }
                    : null),
          ],
        ),
        BottomBar(
            text: AppLocalizations.of(context).continueText,
            onTap: () {
              // widget.onVerificationDone();
              signIn();
            }),
      ],
    );
  }

  startPhoneAuth(BuildContext context, String mobileNumber) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: mobileNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
// ANDROID ONLY!

        // Sign the user in (or link) with the auto-generated credential

        // await FirebaseAuth.instance.signInWithCredential(credential);

        if (credential != null) {
          UserCredential userCredential =
              await FirebaseAuth.instance.signInWithCredential(credential);

          if (userCredential != null) {
            User user = userCredential.user;
            String userToken = await user.getIdToken(true);
            if (user != null) {
              await Preference.setString(PrefKeys.userPassword, userToken);
              Navigator.of(context).pop(userToken);
              // loginApi(model,userToken);

            }
          }
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          // print('The provided phone number is not valid.');
          // showMessage(lang.api("invalid mobile number"));
          UI.toast("invalid mobile number");
        }
      },
      codeSent: (String verificationId, int resendToken) {
        // setState(() {
        //   _startTimer();
        // });

        verifyPhoneNumber();
        UI.toast("code resend");
        // navigateToVeriifcation(context, mobileNumber,verificationId,model);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  signIn() async {
    if (_controller.text.length != 6) {
      UI.toast(AppLocalizations.of(context).invalidOTP);
    } else {
      // Create a PhoneAuthCredential with the code
      AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: widget.verificationCode, smsCode: _controller.text);

      // Sign the user in (or link) with the credential
      if (credential != null) {
        FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((userCredential) async {
          if (userCredential != null) {
            User user = userCredential.user;
            String userToken = await user.getIdToken(true);
            if (user != null) {
              Preference.setString(PrefKeys.userPassword, userToken);
              Navigator.of(context).pop(userToken);
            }
          }
        }).onError((error, stackTrace) {
          if (error.toString().contains('credential is invalid')) {
            print(error.toString());

            UI.toast(AppLocalizations.of(context).invalidEmail);
          } else {
            UI.toast(AppLocalizations.of(context).invalidOTP);
          }
          // The sms verification code used to create the phone auth credential is invalid. Please resend the verification code sms and be sure use the verification code provided by the user
        });
      }
    }
  }
}
