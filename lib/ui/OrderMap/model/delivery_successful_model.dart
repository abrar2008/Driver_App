import 'package:EfendimDriverApp/core/models/order_details_model.dart';
import 'package:base_notifier/base_notifier.dart';
import 'package:flutter/material.dart';
import 'package:EfendimDriverApp/core/api/http_api.dart';
import 'package:EfendimDriverApp/core/auth/authentication_service.dart';
import 'package:ui_utils/ui_utils.dart';
import 'package:EfendimDriverApp/core/constants/constants.dart';
import 'dart:convert';


class DeliverySuccessfulModel extends BaseNotifier {
  final HttpApi api;
  final AuthenticationService auth;
  final BuildContext context;
  final Total orderDetails;




  DeliverySuccessfulModel(
      {NotifierState state, this.api, this.auth, this.context, this.orderDetails})
      : super(state: state) {
    // get document status
    getOrder();


  }





  OrderModel orderModel;


  void getOrder() async
  {
    setBusy();

    final body =
    {
      'token': auth.user.details.token,
      'app_version': Constants.APP_VERSION,
      'api_key': Constants.API_KEY,
    };

    final res = await api.getOrderDetails(context, body: body);
    res.fold((e)
    {
      UI.toast(e.toString());
      setError();
    }, (data) {
      data = json.decode(data);
      orderModel = OrderModel.fromJson(data);
      print(orderModel.details.total.total);

      setIdle();
    });
  }





}
