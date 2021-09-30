import 'package:EfendimDriverApp/ui/Account/UI/ListItems/insight_page.dart';
import 'package:EfendimDriverApp/ui/Locale/locales.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:EfendimDriverApp/core/api/http_api.dart';
import 'package:EfendimDriverApp/core/localizations/global_translations.dart';
import 'package:EfendimDriverApp/core/auth/authentication_service.dart';
import 'package:EfendimDriverApp/theme_cubit.dart';
import 'package:EfendimDriverApp/ui/routes%20copy/route_new.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/notification/notification_service.dart';
import 'core/preference/preference.dart';
import 'package:audioplayers/audio_cache.dart';

import 'core/api/api.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  AudioCache player = new AudioCache();
  const alarmAudioPath = "mynotsound.mp3";
  /* const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'fcm_default_channel'
        'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    sound: RawResourceAndroidNotificationSound('mynotsound'),
    playSound: false,
    importance: Importance.high,
  );*/
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.

  //await Firebase.initializeApp();
  print("creating BackgroundHandler");
  print('A new onMessageOpenedApp event was published!');
  print('Handling a background message ${message.messageId}');
  await player.play(alarmAudioPath);

  // RemoteNotification notification = message.notification;
  // AndroidNotification android = message.notification?.android;
//  print("Obackground message");

  /*if (notification != null && android != null) {
  print("background message2");
 flutterLocalNotificationsPlugin
  ..show(
          notification.hashCode,
         notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channel.description,
              sound: const RawResourceAndroidNotificationSound('mynotsound'),
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
            ),
          ));
  }*/
}

/// Create a [AndroidNotificationChannel] for heads up notifications

/// Initialize the [FlutterLocalNotificationsPlugin] package.
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.subscribeToTopic('doum');
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'fcm_default_channel'
        'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    sound: RawResourceAndroidNotificationSound('mynotsound'),
    playSound: true,
    importance: Importance.High,
  );
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  await Preference.init();

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification notification = message.notification;
    AndroidNotification android = message.notification?.android;
    print("On,essage");

    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
              AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,

                enableLights: true,
                color: const Color.fromARGB(255, 255, 0, 0),
                ledColor: const Color.fromARGB(255, 255, 0, 0),
                ledOnMs: 1000, playSound: true,

                ledOffMs: 500,
                sound: const RawResourceAndroidNotificationSound('mynotsound'),
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: 'launch_background',
                styleInformation: BigTextStyleInformation(''),
              ),
              IOSNotificationDetails()));
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    //await Firebase.initializeApp();

    print("Notif pressed");
  });

  //FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage message) {
  //If there is data in our notification
  //  if (message != null) {
  // print(message.notification.body);
  //We will open the route from the field view
  //with the value definied in the notification
  // _navigator.currentState.pushNamed('/' + message.data['view']);
  //}
  // });

  //d.getAllnews3();
  runApp(EfendimDriverApp());
}

class EfendimDriverApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MultiProvider(
        providers: [
          // Api service
          Provider<Api>(create: (_) => HttpApi()),

          // Auth Service
          ProxyProvider<Api, AuthenticationService>(
              update: (context, api, authenticationService) =>
                  AuthenticationService(api: api)),

          // Notification Service
          ProxyProvider<AuthenticationService, NotificationService>(
              update: (context, auth, notificationService) =>
                  NotificationService(auth: auth)),
          // global trasnlations provider
          ChangeNotifierProvider<GlobalTranslations>(
              create: (_) => GlobalTranslations()),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<ThemeCubit>(
              create: (context) => ThemeCubit(),
            ),
          ],
          child: BlocBuilder<ThemeCubit, ThemeData>(
            builder: (_, theme) {
              return Consumer<GlobalTranslations>(
                  builder: (context, lang, child) {
                return GetMaterialApp(
                  localizationsDelegates: [
                    const AppLocalizationsDelegate(),
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  supportedLocales: [
                    const Locale('en'),
                    const Locale('ar'),
                    const Locale('pt'),
                    const Locale('fr'),
                    const Locale('id'),
                    const Locale('es'),
                  ],
                  localeResolutionCallback: (currentLang, supportLang) {
                    if (currentLang != null) {
                      for (Locale locale in supportLang) {
                        if (locale.languageCode == currentLang.languageCode) {
                          return currentLang;
                        }
                      }
                    }
                    return supportLang.first;
                  },
                  locale: lang.locale,
                  theme: theme,

                  home: InsightPage(),
                  // routes: PageRoutes().routes(),
                  debugShowCheckedModeBanner: false,
                );
              });
            },
          ),
        ),
      ),
    );
  }
}
