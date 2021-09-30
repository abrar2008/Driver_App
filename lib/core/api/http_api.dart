import 'dart:io';

import 'package:dio/dio.dart';
import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';
import 'package:EfendimDriverApp/core/ServerErrorModel/server_error.dart';
import 'package:image_picker_platform_interface/src/types/picked_file/unsupported.dart';
import 'package:logger/logger.dart';
import 'api.dart';
import 'dart:convert';
import 'package:EfendimDriverApp/ui/DeliveryPartnerProfile/model/delivery_profile_model.dart';

class HttpApi implements Api {
  Future<Either<ServerError, dynamic>> request(String endPoint,
      {body,
      BuildContext context,
      String serverPath = 'https://efendim.biz/driver/api/',
      Function onSendProgress,
      Map<String, dynamic> headers,
      String type = RequestType.Get,
      Map<String, dynamic> queryParameters,
      String contentType = Headers.jsonContentType,
      bool retry = false,
      ResponseType responseType = ResponseType.json}) async {
    Response response;

    final dio = Dio(BaseOptions(
      baseUrl: serverPath,
      connectTimeout: 60000,
      receiveTimeout: 60000,
    ));

    final options = Options(
        headers: headers, contentType: contentType, responseType: responseType);

    if (onSendProgress == null) {
      onSendProgress = (int sent, int total) {
        print('$endPoint\n sent: $sent total: $total\n');
      };
    }

    try {
      switch (type) {
        case RequestType.Get:
          {
            response = await dio.get(serverPath + endPoint,
                queryParameters: queryParameters, options: options);
          }
          break;
        case RequestType.Post:
          {
            response = await dio.post(serverPath + endPoint,
                queryParameters: queryParameters,
                onSendProgress: onSendProgress,
                data: body,
                options: options);
          }
          break;
        case RequestType.Put:
          {
            response = await dio.put(
                endPoint,
                queryParameters: queryParameters,
                data: body,
                options: options
            );
          }
          break;
        case RequestType.Delete:
          {
            response = await dio.delete(endPoint,
                queryParameters: queryParameters, data: body, options: options);
          }
          break;
        default:
          break;
      }

      Logger().i(
          ">>> $type $serverPath$endPoint\n$headers\n Param:$queryParameters");

      if (response.statusCode == 201 || response.statusCode == 200) {
        Logger().i(response.data);
        // if (json.decode(response.data)['code'] == '1')
        return Right(response.data); //map of string dynamic...
        // else
        //   return null;
      } else {
        return Left(ServerError(response.data['message']));
      }
    } on DioError catch (e) {
      // if (e.response != null) {
      //   if (e.response.statusCode == 401 &&
      //       !retry &&
      //       context != null &&
      //       (e.response.data != null &&
      //           e.response.data["message"] != "invalid password")) {
      //     // sending Refresh token
      //     Logger().w('Try to send refresh token');
      //     if (await refreshToken(context)) {
      //       return await request(endPoint,
      //           body: body,
      //           queryParameters: queryParameters,
      //           serverPath: serverPath,
      //           headers: Header.userAuth,
      //           context: context,
      //           type: type,
      //           contentType: contentType,
      //           responseType: responseType,
      //           retry: true);
      //     }
      //   } else if (e.response.statusCode == 401 && retry && context != null) {
      //     Logger().w("Checking session expired");
      //     // await checkSessionExpired(context: context, response: e.response);
      //     return Left(ServerError(e.message ?? "Error"));
      //   }
      // } else {
      //   return Left(ServerError(e.response.data['message']));
      // }
      var error = e.message;
      return Left(ServerError(error));
    }
  }

  // getUserByUserId(context, {String userId}) async {
  //   final res = await request(
  //     EndPoint.GET_USER_BY_ID + userId,
  //     context: context,
  //     type: RequestType.Get,
  //     headers: Header.userAuth,
  //   );
  //   return res;
  // }
  //

  Future<Either<ServerError, dynamic>> getAppTranslations(BuildContext context,
      {Map<String, String> body}) async {
    final res = await request(EndPoint.APP_SETTINGS,
        contentType: Headers.formUrlEncodedContentType,
        context: context,
        type: RequestType.Post,
        body: body);
    return res;
  }

  @override
  Future<Either<ServerError, dynamic>> signIn(BuildContext context,
      {Map<String, dynamic> body, @required bool withPhone}) async {
    final res = await request(
        withPhone ? EndPoint.SIGNINWITHMOBILE : EndPoint.SIGNIN,
        contentType: Headers.formUrlEncodedContentType,
        context: context,
        type: RequestType.Post,
        body: body);
    Logger().wtf(body);
    return res;
  }

  @override
  Future<Either<ServerError, dynamic>> signUp(BuildContext context,
      {Map<String, dynamic> body}) async {
    final res = await request(EndPoint.SIGNUP,
        contentType: Headers.formUrlEncodedContentType,
        context: context,
        type: RequestType.Post,
        body: body);
    // Logger().wtf(res);
    return res;
  }

  getUserProfile(BuildContext context, {Map<String, dynamic> body}) async {
    final res = await request(EndPoint.PROFILE,
        contentType: Headers.formUrlEncodedContentType,
        context: context,
        type: RequestType.Post,
        body: body);
    print(res);
    return res;
  }

  Future<Either<ServerError, dynamic>> getLanguageList(BuildContext context,
      {Map<String, String> body, }) async {
    final res = await request(EndPoint.LANGUAGE_LIST,
        contentType: Headers.formUrlEncodedContentType,
        context: context,
        type: RequestType.Post,
        body: body);
    return res;
  }

  Future<Either<ServerError, dynamic>> getTransportVehicle(BuildContext context,
      {Map<String, String> body}) async {
    final res = await request(EndPoint.TRANSPORT_VEHICLE,
        contentType: Headers.formUrlEncodedContentType,
        context: context,
        type: RequestType.Post,
        body: body);
    return res;
  }

  Future<Either<ServerError, dynamic>> getNotifications(BuildContext context,
      {Map<String, String> body}) async {
    final res = await request(EndPoint.NOTIFICATIONS,
        contentType: Headers.formUrlEncodedContentType,
        context: context,
        type: RequestType.Post,
        body: body);
    return res;
  }

  Future<Either<ServerError, dynamic>> clearNotifications(BuildContext context,
      {Map<String, String> body}) async {
    final res = await request(EndPoint.CLEAR_NOTIFICATIONS,
        contentType: Headers.formUrlEncodedContentType,
        context: context,
        type: RequestType.Post,
        body: body);
    return res;
  }

  Future<Either<ServerError, dynamic>> getUserWallet(BuildContext context,
      {Map<String, String> body}) async {
    final res = await request(EndPoint.USER_WALLET,
        contentType: Headers.formUrlEncodedContentType,
        context: context,
        type: RequestType.Post,
        body: body);
    return res;
  }

  getOrderDetails(BuildContext context, {Map<String, String> body}) async {
    final res = await request(EndPoint.ORDER_DETAILS,
        contentType: Headers.formUrlEncodedContentType,
        context: context,
        type: RequestType.Post,
        body: body);
    return res;
  }

  Future<Either<ServerError, dynamic>> getNewTask(BuildContext context,
      {Map<String, String> body}) async {
    final res = await request(EndPoint.NEW_TASK,
        contentType: Headers.formUrlEncodedContentType,
        context: context,
        type: RequestType.Post,
        body: body);
    return res;
  }

  uploadImage(BuildContext context, File imageFile,
      {Map<String, String> body, ImageType type}) async {
    String endPoint;
    switch (type) {
      case ImageType.LICENSE:
        endPoint = EndPoint.UPLOAD_LICENSE_IMAGE;
        break;
      case ImageType.PROFILE:
        endPoint = EndPoint.UPLOAD_PROFILE_IMAGE;
        break;
      case ImageType.GOVERNMENT_ID:
        endPoint = EndPoint.UPLOAD_GOVERN_IMAGE;
        break;
    }

    final res = await request(
      endPoint,
      type: RequestType.Post,
      context: context,
      // contentType:,
      // headers: Header.clientAuth,

      body: FormData.fromMap(
          {"file": await MultipartFile.fromFile(imageFile.path), ...body}),
    );

    // Logger().wtf(json.dec);
    return res;
  }

  Future<Either<ServerError, dynamic>> getDocumentStatus(BuildContext context,
      {Map<String, String> body}) async {
    final res = await request(EndPoint.DOCUMENT_STATUS,
        contentType: Headers.formUrlEncodedContentType,
        context: context,
        type: RequestType.Post,
        body: body);

    return res;
  }

  Future<Either<ServerError, dynamic>> updateProfile(BuildContext context,
      {Map body}) async {
    //UpdateProfile
    final res = await request(EndPoint.UPDATE_PROFILE,
        contentType: Headers.formUrlEncodedContentType,
        context: context,
        type: RequestType.Post,
        body: body);
    return res;
  }

  Future<Either<ServerError, dynamic>> changeOrderStatus(BuildContext context,
      {Map<String, String> body}) async {
    final res = await request(EndPoint.CHANGE_ORDER_STATUS,
        contentType: Headers.formUrlEncodedContentType,
        context: context,
        type: RequestType.Post,
        body: body);
    return res;
  }

  Future<Either<ServerError, dynamic>> getAllTasks(BuildContext context,
      {Map<String, String> body}) async {
    final res = await request(EndPoint.ALL_ORDERS,
        contentType: Headers.formUrlEncodedContentType,
        context: context,
        type: RequestType.Post,
        body: body);
    return res;
  }

  Future<Either<ServerError, dynamic>> updateFCM(
      {Map<String, dynamic> body}) async {
    final res = await request(EndPoint.UPDATE_FCM,
        contentType: Headers.formUrlEncodedContentType,
        type: RequestType.Post,
        body: body);
    return res;
  }

  Future<Either<ServerError, dynamic>> changeDutyStatus(BuildContext context,
      {Map<String, String> body}) async {
    final res = await request(EndPoint.CHANGE_DUTY_STATUS,
        contentType: Headers.formUrlEncodedContentType,
        type: RequestType.Post,
        body: body);
    return res;
  }
}
