import 'package:EfendimDriverApp/core/localizations/global_translations.dart';
import 'package:EfendimDriverApp/core/preference/preference.dart';
import 'package:EfendimDriverApp/ui/Themes/colors.dart';
import 'package:base_notifier/base_notifier.dart';
import 'package:EfendimDriverApp/core/auth/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:EfendimDriverApp/core/api/http_api.dart';
import 'package:EfendimDriverApp/core/notification/notification_service.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:ui_utils/ui_utils.dart';
import 'package:EfendimDriverApp/ui/routes%20copy/route_new.dart';
import 'package:provider/provider.dart';
import 'package:EfendimDriverApp/core/constants/constants.dart';

class PhoneNumberPageModel extends BaseNotifier {
  final HttpApi api;
  final AuthenticationService auth;
  final BuildContext context;
  PhoneNumberPageModel({NotifierState state, this.api, this.auth, this.context})
      : super(state: state);
  SmsAutoFill autoFill = SmsAutoFill();

  void signin({String phoneNumber, String token}) async {
    print("token:$token");
    final body = {
      'username': 'basil',
      'auth_token': token,
      'login_type': 'firebase',
      'app_version': '1.8.0',
      'api_key': 'afandimhonyarajoul'
    };

    final phoneBody = {
      // 'phone': '+905525213364',
      'phone': phoneNumber,
      'auth_token': token,
      'login_type': 'firebase',
      'app_version': Constants.APP_VERSION,
      'api_key': Constants.API_KEY
    };

    // final phoneBody = {
    // 'phone': '+905525213364',
    //  'phone': phoneNumber,
    //  'password': token,
    //  'app_version': Constants.APP_VERSION,
    //  'api_key': Constants.API_KEY
    // };
    setBusy();

    Preference.setString(PrefKeys.userMobile, phoneNumber);
    final res = await auth.signIn(context, body: phoneBody, withPhone: false);
    print("res :$res");
    if (res['key'] == 1) {
      // init fcm
      await Provider.of<NotificationService>(context, listen: false)
          .init(context);
      Preference.setBool("islogin", true);

      // successful

      UI.toast(res['value']);

      UI.pushReplaceAll(context, Routes.allTasks);
    } else if (res['key'] == 2) {
      final lang = Provider.of<GlobalTranslations>(context, listen: false);

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(lang.translate("register")),
              content: Text(lang.translate("wants to register new ")),
              actions: <Widget>[
                FlatButton(
                    child: Text(lang.translate("no").toUpperCase()),
                    textColor: kMainColor,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: kTransparentColor)),
                    onPressed: () =>
                        UI.pushReplaceAll(context, Routes.phoneNumber)),
                FlatButton(
                    child: Text(lang.translate("yes").toUpperCase()),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: kTransparentColor)),
                    textColor: kMainColor,
                    onPressed: () {
                      UI.push(context, Routes.registerPage);

                      // Phoenix.rebirth(context);
                    })
              ],
            );
          });

      // Something is wrong
      UI.toast(res['value']);
    } else {
      UI.toast("Error");
    }

    setIdle();
  }
}
