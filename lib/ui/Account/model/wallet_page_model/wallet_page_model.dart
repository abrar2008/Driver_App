import 'dart:convert';

import 'package:base_notifier/base_notifier.dart';
import 'package:flutter/material.dart';
import 'package:EfendimDriverApp/core/api/http_api.dart';
import 'package:EfendimDriverApp/core/auth/authentication_service.dart';
import 'package:EfendimDriverApp/core/constants/constants.dart';
import 'package:EfendimDriverApp/core/models/driver_wallet_model.dart';

class WalletPageModel extends BaseNotifier {
  final HttpApi api;
  final AuthenticationService auth;
  final BuildContext context;

  String errorMsg = '';

  DriverWalletModel wallet;

  WalletPageModel({NotifierState state, this.api, this.auth, this.context})
      : super(state: state) {
    getUserWallet();
  }

  getUserWallet() async {
    // Make body of request
    final body = {
      'api_key': Constants.API_KEY,
      'lang': Constants.APP_LANGUAGE,
      'app_version': Constants.APP_VERSION,
      'token': auth.user.details.token
    };

    setBusy();
    final res = await api.getUserWallet(context, body: body);
    res.fold((e) {
      // Something is wrong with server
      errorMsg = e.toString();
      setError();
    }, (data) {
      // data is here
      //
      // convert data to json
      data = json.decode(data);

      if (data['code'] == 1) {
        errorMsg = data['msg'];
        setError();
      } else {
        if (data['details'] is List) {
          wallet = DriverWalletModel.fromJson(data);
          setIdle();
        } else {
          //#TODO: translate this
          errorMsg = 'Start delivering orders to increase your wallet';
          setError();
        }
      }
    });
  }
}
