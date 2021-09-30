import 'package:EfendimDriverApp/ui/Account/UI/ListItems/account_page.dart';
import 'package:EfendimDriverApp/ui/Account/UI/ListItems/history.dart';
import 'package:EfendimDriverApp/ui/Account/UI/ListItems/webview_t&c.dart';
import 'package:EfendimDriverApp/ui/Auth/MobileNumber/UI/phone_number%20copy.dart';
import 'package:EfendimDriverApp/ui/Auth/Registration/UI/upload_document_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:EfendimDriverApp/ui/Account/UI/ListItems/addtobank_page.dart';
import 'package:EfendimDriverApp/ui/Account/UI/ListItems/insight_page.dart';
import 'package:EfendimDriverApp/ui/Account/UI/ListItems/settings_page.dart';
import 'package:EfendimDriverApp/ui/Account/UI/ListItems/support_page.dart';
import 'package:EfendimDriverApp/ui/Account/UI/ListItems/tnc_page.dart';
import 'package:EfendimDriverApp/ui/Account/UI/ListItems/notification_page.dart';
import 'package:EfendimDriverApp/ui/Account/UI/ListItems/wallet/wallet_page.dart';
import 'package:EfendimDriverApp/ui/Auth/MobileNumber/UI/phone_number.dart';
import 'package:EfendimDriverApp/ui/Auth/Registration/UI/register_page.dart';
import 'package:EfendimDriverApp/ui/Auth/Verification/UI/verification_page.dart';
import 'package:EfendimDriverApp/ui/Auth/login_navigator.dart';
import 'package:EfendimDriverApp/ui/Auth/social.dart';
import 'package:EfendimDriverApp/ui/DeliveryPartnerProfile/delivery_profile.dart';
import 'package:EfendimDriverApp/ui/OrderMap/UI/delivery_successful.dart';
import 'package:EfendimDriverApp/ui/OrderMap/UI/new_delivery.dart';
import 'package:EfendimDriverApp/ui/splash/splash_page.dart';
import 'package:EfendimDriverApp/ui/Account/UI/ListItems/all_tasks.dart';
import 'package:EfendimDriverApp/core/models/new_order.dart';

class Routes {
  static Widget current;

  static Widget _setRoute(Widget route) {
    current = route;
    return route;
  }

  static Widget get splash => _setRoute(SplashScreenPage());
  static Widget get phoneNumber => _setRoute(PhoneNumber1());
  // static Widget get editProfile => _setRoute(ProfilePage());
  // static Widget get login => _setRoute(PhoneNumber());
  static Widget get socialLogIn => _setRoute(SocialLogIn());
  static Widget get registerPage => _setRoute(RegisterPage());
  // static Widget get verificationPage => _setRoute(VerificationPage());

  static Widget get accountPage => _setRoute(AccountPage());
  static Widget get tncPage => _setRoute(Termsconditions(
        title: "Terms and conditions",
        selectedUrl: "https://apps.efendim.biz/terms-of-use/",
      ));
  static Widget get notification => _setRoute(NotificationPage());
  static Widget get supportPage => _setRoute(SupportPage());
  static Widget get loginNavigator => _setRoute(LoginNavigator());
  static Widget get deliverySuccessful => _setRoute(DeliverySuccessful());
  static Widget get insightPage => _setRoute(InsightPage());
  static Widget get walletPage => _setRoute(WalletPage());
  static Widget get addToBank => _setRoute(AddToBank());
  static Widget get profilePage => _setRoute(ProfilePage());
  static Widget newDeliveryPage({Details newTask}) =>
      _setRoute(NewDeliveryPage(newTask: newTask));
  static Widget get settings => _setRoute(SettingsPage());
  static Widget get allTasks => _setRoute(AllTasksPage());
  static Widget get uploadDocs => _setRoute(UploadDocumentPage());

  static Widget get history => _setRoute(History());
}
