import 'package:ui_utils/ui_utils.dart';
import 'dart:convert';
import 'package:EfendimDriverApp/core/constants/constants.dart';
import 'package:EfendimDriverApp/core/api/http_api.dart';
import 'package:EfendimDriverApp/core/auth/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:base_notifier/base_notifier.dart';
import 'package:EfendimDriverApp/core/localizations/global_translations.dart';

class SettingsPageModel extends BaseNotifier {
  final HttpApi api;
  final AuthenticationService auth;
  final BuildContext context;

  final GlobalTranslations lang = GlobalTranslations();

  List<String> languagesKeys = [];
  List<String> languagesValues = [];


  SettingsPageModel({NotifierState state, this.api, this.auth, this.context})
      : super(state: state) {
    getLanguageList();
  }

  getLanguageList() async {
    final body = {
      'api_key': Constants.API_KEY,
      'app_version': Constants.APP_VERSION,
    };
    setBusy();
    final res = await api.getLanguageList(context, body: body);
    res.fold((e) {
      UI.toast(lang.translate("ERROR: Something went wrong"));
      setError();
    }, (data) {
      // convert data to json
      final Map convertedData = json.decode(data);

      if (convertedData.containsKey('details')) {
        convertedData['details'].forEach((key, value) {
          languagesKeys.add(key);
          languagesValues.add(value);
        });
      }

      setIdle();
    });
  }
}
