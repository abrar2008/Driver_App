import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';
import 'package:EfendimDriverApp/core/ServerErrorModel/server_error.dart';
import 'package:EfendimDriverApp/core/preference/preference.dart';

class RequestType {
  static const String Get = 'get';
  static const String Post = 'post';
  static const String Put = 'put';
  static const String Delete = 'delete';
}

class Header {
  // static Map<String, dynamic> clientAuth({@required String clientID}) {
  //   final hashedClient = const Base64Encoder().convert("$clientID:".codeUnits);
  //   return {'Authorization': 'Basic $hashedClient'};
  // }

  static Map<String, dynamic> get clientAuth => {
        'Authorization':
            'Bearer 5A4674F5B7714CB7B3FAD9073900C6B2525FD3034DEC7F6F742557C9326F334EAE9045E8D4B9DF9B19A47DFCDCFF14F3'
      };

  static Map<String, dynamic> get userAuth =>
      {'Authorization': 'Bearer ${Preference.getString(PrefKeys.token)}'};
}

class EndPoint {
  static const String APP_SETTINGS = 'GetAppSettings';
  static const String SIGNUP = 'signup';
  static const String SIGNIN = 'login';
  static const String SIGNINWITHMOBILE = 'LoginWithPhone';
  static const String PROFILE = 'GetProfile';
  static const String TRANSPORT_VEHICLE = 'GetTransport';
  static const String NOTIFICATIONS = 'GetNotifications';
  static const String CLEAR_NOTIFICATIONS = 'clearNofications';
  static const String USER_WALLET = 'driverWallet';
  static const String ORDER_DETAILS = 'ViewOrderDetails';
  static const String NEW_TASK = 'getNewTask';
  static const String UPLOAD_PROFILE_IMAGE = 'UploadProfile';
  static const String UPLOAD_LICENSE_IMAGE = 'UploadLicense';
  static const String UPLOAD_GOVERN_IMAGE = 'UploadGovernmentId';
  static const String DOCUMENT_STATUS = 'GetDocumentStatus';
  static const String LANGUAGE_LIST = 'LanguageList';
  static const String UPDATE_PROFILE = 'UpdateProfile';
  static const String CHANGE_ORDER_STATUS = 'changeTaskStatus';
  static const String ALL_ORDERS = 'getTaskCompleted';
  static const String UPDATE_FCM = 'reRegisterDevice';
  static const String CHANGE_DUTY_STATUS = 'ChangeDutyStatus';
}

abstract class Api {
  Future<Either<ServerError, dynamic>> signUp(BuildContext context,
      {Map<String, dynamic> body});

  Future<Either<ServerError, dynamic>> signIn(BuildContext context,
      {Map<String, dynamic> body});
}
