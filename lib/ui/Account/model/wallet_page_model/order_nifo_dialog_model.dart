import 'dart:developer';

import 'package:base_notifier/base_notifier.dart';
import 'package:flutter/material.dart';
import 'package:EfendimDriverApp/core/auth/authentication_service.dart';
import 'package:EfendimDriverApp/core/api/http_api.dart';
import 'package:EfendimDriverApp/core/constants/constants.dart';
import 'package:EfendimDriverApp/core/models/order_details_model.dart';
import 'dart:convert';

class OrderInfoDialogModel extends BaseNotifier {
  final HttpApi api;
  final AuthenticationService auth;
  final BuildContext context;
  final String orderId;

  OrderModel order;
  String errorMsg = '';

  OrderInfoDialogModel(
      {NotifierState state, this.api, this.auth, this.context, this.orderId})
      : super(state: state) {
    getOrderDetails();
  }

  getOrderDetails() async {
    // Make body
    final body = {
      'api_key': Constants.API_KEY,
      'lang': Constants.APP_LANGUAGE,
      'app_version': Constants.APP_VERSION,
      'token': auth.user.details.token,
      'order_id': orderId,
    };

    setBusy();
    final res = await api.getOrderDetails(context, body: body);
    res.fold((e) {
      // Something is wrong with server
      errorMsg = e.toString();
      setError();
    }, (data) {
      // data is here
      //
      // convert data to json
      data = json.decode(data);
      log("message..$res");
      if (data['code'] == 2) {
        errorMsg = data['msg'];
        setError();
      } else {
        order = OrderModel.fromJson(data);
        setIdle();
      }
    });
  }
}
