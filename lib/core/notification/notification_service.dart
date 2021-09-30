import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:EfendimDriverApp/main.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:EfendimDriverApp/core/preference/preference.dart';
import 'package:EfendimDriverApp/ui/Components/notification_widget.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:overlay_support/overlay_support.dart';

import '../auth/authentication_service.dart';

/*
* 🦄initiated at the app start to listen to notifications..
*/
class NotificationService {
  final AuthenticationService auth;
  List<dynamic> userNotifications;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  NotificationService({this.auth});

  Future<void> init(context) async {
    String token = await _firebaseMessaging.getToken();
    print("Firebase token : $token");

    //_firebaseMessaging.configure(
    //  onMessage: (Map<String, dynamic> message) async {
    //   print("onMessage : $message");
    //   operateMessage(message);
    //   },
    // onResume: (Map<String, dynamic> message) async {
    // if (message.containsKey("data") && auth.userLoged) {
    //   navigatorKey.currentState.push(MaterialPageRoute(
    //     builder: (_) =>
    //         ChatPage(doctorId: message['notification']['data']['toUserId']),
    //   ));
    // } else {
    //   navigatorKey.currentState
    //       .push(MaterialPageRoute(builder: (_) => SignInPage()));
    // }
    //  operateMessage(message);
    // print("onResume : $message");
    //  },
    //  onLaunch: (Map<String, dynamic> message) async {
    // if (message.containsKey("data") && auth.userLoged) {
    //   navigatorKey.currentState.push(MaterialPageRoute(
    //     builder: (_) =>
    //         ChatPage(doctorId: message['notification']['data']['toUserId']),
    //   ));
    // } else {
    //   navigatorKey.currentState
    //       .push(MaterialPageRoute(builder: (_) => SignInPage()));
    // }
    // operateMessage(message);
    //  print("onLunch : $message");
    // },
    // );

    //  if (Platform.isIOS) await getIOSPermission();

    await updateFCMToken(token);
  }

  Future<void> updateFCMToken(token) async {
    if (token != null) {
      try {
        Preference.setString(PrefKeys.fcmToken, token);
        await auth.updateFCM(fcm: token);

        print('new fcm:$token');
      } catch (e) {
        print('error updating fcm');
      }
    }
  }

  // operateMessage(Map<String, dynamic> message,
  //   {bool showOverlay = true}) async {
  //  String body;
  //  String title;
  //  Map<dynamic, dynamic> data;
  //  final deviceInfo = DeviceInfoPlugin();

  // if (Platform.isIOS &&
  //     int.parse((await deviceInfo.iosInfo).systemVersion.split('.')[0]) <
  //       13) {
  //  final messageData = message['aps']['alert'];
  //    title = messageData['title'];
  //     body = messageData['body'];
  //   data = message['data'];
  //  } else {
  //{notification: {title: Doctor, body: aaaaaaaaaaaaaaa}, data: {toUserId: 5fde1ce2bbfdf011af2005af, formUserId: 5fde1cf3bbfdf011af2005b0}}

  //     final messageData = message['notification'];
  //    //     title = messageData['title'];
  //   body = messageData['body'];
  //    data = message['data'];
  //   }

  //    showOverlayNotification(
  //    (context) => Notify(
  //         body: body,
  //       title: title,
  //          data: data,
  //         ),
  //   duration: Duration(seconds: 10));
  //  }

  //  getIOSPermission() async {
  //  await _firebaseMessaging.requestNotificationPermissions(
  //    const IosNotificationSettings(
  //      sound: true, badge: true, alert: true, provisional: true));

  // final iosSubscription = _firebaseMessaging.onIosSettingsRegistered.listen((data) {
  //       _saveDeviceToken();
  //     });
  //  }

  //  Map _modifyMotificationJson(Map<String, dynamic> message) {
  //  message['data'] = Map.from(message ?? {});
  // message['notification'] = message['aps']['alert'];
  //  return message;
  //  }
  //
  // }

// import 'dart:async';
// import 'package:Docto/core/services/api/http_api.dart';
// import 'package:Docto/core/services/auth/authentication_service.dart';
// import 'package:Docto/ui/widgets/notification_widget.dart';
// import 'package:base_notifier/base_notifier.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:logger/logger.dart';
// import 'package:overlay_support/overlay_support.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

// class NotificationService extends BaseNotifier {
//   final AuthenticationService auth;
//   final HttpApi api;
//   final BuildContext context;

//   IO.Socket _socket;

//   static String _serverIP = "http://server.overrideeg.net";
//   static const int SERVER_PORT = 3335;
//   static String _connectUrl = '$_serverIP:$SERVER_PORT';

//   static NotificationService instance;

//   factory NotificationService(
//       {@required BuildContext context,
//       HttpApi api,
//       AuthenticationService auth}) {
//     instance ??= NotificationService._internalConstructor(
//         context: context, api: api, auth: auth);
//     return instance;
//   }

//   NotificationService._internalConstructor(
//       {@required this.context, this.api, this.auth}) {
//     // AwesomeNotifications().initialize('resource://drawable/res_app_icon', [
//     //   NotificationChannel(
//     //       channelKey: 'basic_channel',
//     //       channelName: 'Basic notifications',
//     //       channelDescription: 'Notification channel for basic tests',
//     //       defaultColor: Color(0xFF9D50DD),
//     //       ledColor: Colors.white)
//     // ]);
//   }

//   StreamSocket streamSocket = StreamSocket();

//   // initSocket() async {s
//   //   if(Platform.isAndroid)
//   //   {
//   //     var methodChannel=MethodChannel("com.doctoapp.notificationModule");
//   //     String data=await methodChannel.invokeMethod("startNotification");
//   //     debugPrint(data);
//   //
//   //   }
//   // }

//   initSocket() async {
//     _socket ??= IO.io(_connectUrl, <String, dynamic>{
//       'transports': ['websocket'],
//     });

//     this._socket.on("connect", (_) {
//       Logger().i('Connected to notificationServer');
//       this._socket.emit("join", auth.user.user.sId);
//     });

//     this._socket.on("notification", (data) async {
//       print(data);
//       // await AwesomeNotifications().createNotification(
//       //     content: NotificationContent(
//       //         id: 15,
//       //         body: data,
//       //         channelKey: 'basic_channel',
//       //         payload: {'secret-command': 'block_user'}));
//       showOverlayNotification((context) => Notify(),
//           duration: Duration(seconds: 50));
//     });
//   }

//   void emitEvent(String eventName, dynamic data) {
//     this._socket.emit(eventName, data);
//   }
// }

// class StreamSocket {
//   final _notificationResponse = StreamController<dynamic>.broadcast();

//   void Function(dynamic) get getNotification => _notificationResponse.sink.add;

//   void dispose() {
//     _notificationResponse.close();
//   }
}
