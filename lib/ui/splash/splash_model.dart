import 'package:base_notifier/base_notifier.dart';
import 'package:flutter/material.dart';
import 'package:EfendimDriverApp/core/api/http_api.dart';
import 'package:EfendimDriverApp/core/auth/authentication_service.dart';
import 'package:EfendimDriverApp/core/constants/constants.dart';
import 'dart:convert';
import 'package:EfendimDriverApp/core/preference/preference.dart';
import 'package:EfendimDriverApp/core/localizations/global_translations.dart';
import 'package:ui_utils/ui_utils.dart';
import 'package:EfendimDriverApp/ui/routes copy/route_new.dart';

class SplashPageModel extends BaseNotifier {
  final HttpApi api;
  final AuthenticationService auth;
  final BuildContext context;
  SplashPageModel({NotifierState state, this.api, this.auth, this.context})
      : super(state: state) {
    // getAppTranslations();
  }





  getAppTranslations() async {
    final body = {
      'app_version': Constants.APP_VERSION,
      'api_key': Constants.API_KEY
    };
    /*final res = await api.getAppTranslations(context, body: body);

    res.fold((e) {
      // // Something is wrong with server
      // errorMsg = e.toString();
      setError();
    }, (data) async {
      // data is here
      //
      // convert data to json
      data = json.decode(data);
      print("firstrun data:$data");

      if (data['code'] == 1) {
        await Preference.setString(Constants.APP_TRANSLATIONS_KEY,
            json.encode(data['details']['translation']));

        GlobalTranslations lang = GlobalTranslations();
        await lang.loadApiLang();*/
        setIdle();

        bool isLogin = Preference.getBool(PrefKeys.userLogged);
        print("islogin : $isLogin");
        if (isLogin != null && isLogin)
          UI.pushReplaceAll(context, Routes.allTasks);
        else
          UI.pushReplaceAll(context, Routes.phoneNumber);
      }


  }

