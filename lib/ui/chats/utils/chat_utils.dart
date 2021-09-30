import 'package:EfendimDriverApp/core/preference/preference.dart';

Future<String> getNotificationToken() async {
  String token = Preference.getString(PrefKeys.fcmToken);
  return token;
}
