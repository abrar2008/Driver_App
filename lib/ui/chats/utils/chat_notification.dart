import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

Future<void> sendNotification({
  @required String title,
  @required String message,
  @required String notificationToken,
}) async {
  Map<String, dynamic> params = {
    'device_id': notificationToken,
    'title': title,
    'body': message,
  };

  await http.get(Uri.https(
    'efendim.biz',
    '/api/send_notification.php',
    params,
  ));
}
