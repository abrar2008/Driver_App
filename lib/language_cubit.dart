import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:EfendimDriverApp/core/preference/preference.dart';

class LanguageCubit extends Cubit<Locale> {
  LanguageCubit() : super(Locale('en'));

  void selectEngLanguage() async {
    await Preference.setString(PrefKeys.languageCode, 'en');
    emit(Locale('en'));
  }

  void selectArabicLanguage() async {
    await Preference.setString(PrefKeys.languageCode, 'ar');
    emit(Locale('ar'));
  }

  void selectPortugueseLanguage() async {
    await Preference.setString(PrefKeys.languageCode, 'pt');
    emit(Locale('pt'));
  }

  void selectFrenchLanguage() async {
    await Preference.setString(PrefKeys.languageCode, 'fr');
    emit(Locale('fr'));
  }

  void selectIndonesianLanguage() async {
    await Preference.setString(PrefKeys.languageCode, 'id');
    emit(Locale('id'));
  }

  void selectSpanishLanguage() async {
    await Preference.setString(PrefKeys.languageCode, 'es');
    emit(Locale('es'));
  }
}
