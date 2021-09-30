import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:EfendimDriverApp/core/constants/constants.dart';
import 'package:EfendimDriverApp/core/preference/preference.dart';

///
/// Preferences related
///
String _defaultLanguage;

const List<String> _supportedLanguages = ['en', 'ar', 'tr'];
const Map<String, String> _supportedLanguagesFull = {
  "en": "English",
  "ar": "العربية",
  "tr": "Türkçe"
};

class GlobalTranslations with ChangeNotifier {
  Locale _locale;
  Map<dynamic, dynamic> _localizedValues;
  Map<dynamic, dynamic> _localizedApiValues;
  bool isSet = true;

  ///
  /// Singleton Factory
  ///
  static final GlobalTranslations _translations =
      new GlobalTranslations._internal();

  factory GlobalTranslations() {
    _defaultLanguage = Platform.localeName.split('_')[0];
    print(_defaultLanguage);
    return _translations;
  }

  GlobalTranslations._internal();

  ///
  /// Returns the list of supported Locales
  ///
  Iterable<Locale> supportedLocales() =>
      _supportedLanguages.map<Locale>((lang) => new Locale(lang, ''));

  ///
  /// One-time initialization
  ///
  Future<Null> init([String language]) async {
    if (_locale == null) {
      await setNewLanguage(language);
    }
    return null;
  }

  Future<Null> setNewLanguage([String newLanguage]) async {
    String language = newLanguage;
    if (language == null) {
      language = Preference.getString(PrefKeys.languageCode);
      Preference.setString(Constants.APP_LANGUAGE, newLanguage);
    }

    // Set the locale

    if (!_supportedLanguages.contains(language)) {
      if (_supportedLanguagesFull.containsValue(language)) {
        // get the corresponding  key of value
        language = _supportedLanguagesFull.keys.firstWhere(
            (element) => _supportedLanguagesFull[element] == language,
            orElse: () => _defaultLanguage);
      } else {
        language = _defaultLanguage;
        isSet = false;
      }
    }
    _locale = Locale(language);
    notifyListeners();
  }

  ///
  /// Returns the translation that corresponds to the [key]
  ///
  String translate(String key) {
    // Return the requested string
    if (_localizedApiValues == null ||
        _localizedApiValues[key] == null ||
        !_supportedLanguagesFull.containsKey(currentLanguage)) {
      // Key not found
      return key;
    } else {
      return _localizedApiValues[key]
              [_supportedLanguagesFull[currentLanguage]] ??
          key;
    }
  }

  ///
  /// Returns the current language code
  ///
  get currentLanguage => _locale == null ? '' : _locale.languageCode;

  ///
  /// Returns the current Locale
  ///
  get locale => _locale;

  ///
  /// Routine to change the language
  ///
  Future<Null> loadApiLang() async {
    String settings = Preference.getString(Constants.APP_TRANSLATIONS_KEY);
    Map settingsMap = json.decode(settings);
    _localizedApiValues = settingsMap;
    // this.settings = settingsMap;
  }

  // String getLanguageText([String langKey]) {
  //   if (_supportedLanguagesFull.containsKey(langKey ?? currentLanguage)) {
  //     return _supportedLanguagesFull[langKey ?? currentLanguage];
  //   } else {
  //     return "";
  //   }
  // }
  //
  //

}
