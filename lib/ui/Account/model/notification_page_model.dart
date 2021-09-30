import 'dart:convert';
import 'package:base_notifier/base_notifier.dart';
import 'package:flutter/material.dart';
import 'package:EfendimDriverApp/core/api/http_api.dart';
import 'package:EfendimDriverApp/core/auth/authentication_service.dart';
import 'package:EfendimDriverApp/core/constants/constants.dart';
import 'package:EfendimDriverApp/core/models/notification_model.dart';
import 'package:EfendimDriverApp/ui/routes%20copy/route_new.dart';
import 'package:ui_utils/ui_utils.dart';

class NotificationPageModel extends BaseNotifier {
  final HttpApi api;
  final AuthenticationService auth;
  final BuildContext context;

  NotificationModel notificationModel;
  String errorString;

  NotificationPageModel(
      {NotifierState state, this.api, this.auth, this.context})
      : super(state: state) {
    getNotifications();
  }

  void getNotifications() async {
    final body = {
      'app_version': Constants.APP_VERSION,
      'token': auth.user.details.token,
      'api_key': Constants.API_KEY,
      'lang': Constants.APP_LANGUAGE,
    };
    setBusy();
    final res = await api.getNotifications(context, body: body);
    res.fold((e) {
      // something error
      errorString = e.toString();
      UI.toast(e.toString());
    }, (data) {
      // convert data to json
      data = json.decode(data);

      // check if code == 2 that means something is error
      if (data['code'] == 2) {
        setError();
        errorString = data['msg'];
      } else {
        // map json to model
        notificationModel = NotificationModel.fromJson(data);
        setIdle();
      }
    });
  }

  void clearNotification() async {
    final body = {
      'app_version': Constants.APP_VERSION,
      'token': auth.user.details.token,
      'api_key': Constants.API_KEY,
      'lang': Constants.APP_LANGUAGE,
    };
    final res = await api.clearNotifications(context, body: body);
    res.fold((e) => UI.toast(e.toString()), (data) {
      // convert data to json
      data = json.decode(data);

      if (data['code'] == 2) {
        UI.toast(data['msg']);
      } else {
        UI.toast(data['msg']);
        notificationModel = null;
        errorString = "No notification";
        setError();
      }
    });
  }
}
