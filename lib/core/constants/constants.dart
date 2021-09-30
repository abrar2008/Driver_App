import 'package:EfendimDriverApp/core/preference/preference.dart';

const String contactUsNumber = "+905510685750";
const String verifyLink = "https://m.me/afandim.net?ref=w11132181";
const String activateLink = "https://m.me/afandim.net?ref=w10540838";
const String contactUsMessenger = "https://m.me/afandim.net?ref=w10540838";
const String contactUsInstagram = "https://www.instagram.com/efendim.biz";
const String contactUsFacebook = "https://www.facebook.com/efendim.biz";

class Constants {
  // static const String API_KEY = 'afandimhonyarajoul';
  static const String API_KEY = 'efendimDriverApp';
  static const String GOOGLE_MAPS_API_KEY =
      'AIzaSyAeQShcjlymL-lN9CE-GzirNRxzT_McEUs';
  static const String APP_VERSION = '1.8.0';
  static final String APP_LANGUAGE =
      Preference.getString(PrefKeys.languageCode) ?? "english";

  static const String APP_TRANSLATIONS_KEY = 'app.translations';


}
