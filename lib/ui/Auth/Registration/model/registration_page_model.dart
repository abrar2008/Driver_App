import 'dart:io';

import 'package:EfendimDriverApp/core/localizations/global_translations.dart';
import 'package:EfendimDriverApp/core/notification/notification_service.dart';
import 'package:EfendimDriverApp/core/preference/preference.dart';
import 'package:EfendimDriverApp/ui/DeliveryPartnerProfile/model/delivery_profile_model.dart';
import 'package:base_notifier/base_notifier.dart';
import 'package:flutter/material.dart';
import 'package:EfendimDriverApp/core/api/http_api.dart';
import 'package:EfendimDriverApp/core/auth/authentication_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:ui_utils/ui_utils.dart';
import 'package:EfendimDriverApp/ui/routes%20copy/route_new.dart';
import 'package:EfendimDriverApp/core/models/transport_model.dart';
import 'dart:convert';
import 'package:EfendimDriverApp/core/constants/constants.dart';
import 'package:provider/provider.dart';

class RegistrationPageModel extends BaseNotifier {
  final HttpApi api;
  final AuthenticationService auth;
  final BuildContext context;
  GlobalTranslations lang = GlobalTranslations();
  final String baseUrl = "https://efendim.biz/upload/driver/";


  FormGroup form;

  String isoCode = '';

  // for fetching transport vehicles ( car, truck, ...)
  bool fetchingTransport = false;
  TransportVehicle vehicles;
  List types = [];
  dynamic selectedItem;

  RegistrationPageModel(
      {NotifierState state, this.api, this.auth, this.context})
      : super(state: state) {
    getTransport();
    form = FormGroup(
      {
        'first_name': FormControl(validators: [Validators.required]),
        'last_name': FormControl(validators: [Validators.required]),
        'email':
            FormControl(validators: [Validators.required, Validators.email]),
        'phone': FormControl(value: Preference.getString(PrefKeys.userMobile)),
        'username': FormControl(validators: [Validators.required]),
        'password':
            FormControl(value: Preference.getString(PrefKeys.userPassword)),
        'confirm_password':
            FormControl(value: Preference.getString(PrefKeys.userPassword)),
        'api_key': FormControl(value: Constants.API_KEY),
        'app_version': FormControl(value: Constants.APP_VERSION),
        'transport_type_id': FormControl(value: 'bike')
      },
      disabled: false,
    );
    form.markAllAsTouched();
  }

  void getTransport() async {
    final body = {
      'app_version': Constants.APP_VERSION,
      'api_key': Constants.API_KEY,
    };
    fetchingTransport = true;
    setState();
    var res = await api.getTransportVehicle(context, body: body);
    res.fold((e) => UI.toast(e.toString()), (data) {
      // convert data to json
      data = json.decode(data);

      vehicles = TransportVehicle.fromJson(data);
      vehicles.details.toJson().forEach((key, value) {
        types.add({'key': key, 'value': value});
      });
    });

    print(types);

    fetchingTransport = false;
    setState();
  }

  void signUp() async {
    //   if (form.control('email').value == null) {
    if (form.valid) {
      // UI.toast("Error");
      //} else
      // {

      // final mob = form.control('phone').value;

      setBusy();
      // form.control('phone').updateValue(isoCode + mob);
      final res = await auth.signUp(context, body: form.value);
      // form.control('phone').updateValue(mob);

      if (res['key'] == 0) {
        UI.toast("Error");
      } else if (res['key'] == 1) {
        UI.toast(res['value']);

        final phoneBody = {
          // 'phone': '+905525213364',
          'phone': Preference.getString(PrefKeys.userMobile),
          'auth_token': Preference.getString(PrefKeys.userPassword),
          'login_type': 'firebase',
          'app_version': Constants.APP_VERSION,
          'api_key': Constants.API_KEY
        };
        print("login aftr reg : ${phoneBody['auth_token']}");

        final res2 =
            await auth.signIn(context, body: phoneBody, withPhone: false);
        print("res :$res2");
        if (res2['key'] == 1) {
          // init fcm
          await Provider.of<NotificationService>(context, listen: false)
              .init(context);
          Preference.setBool("islogin", true);

          // successful
          UI.toast(res2['value']);
          UI.pushReplaceAll(context, Routes.uploadDocs);
        } else if (res2['key'] == 2) {
          // Something is wrong
          UI.toast(res2['value']);
          //  UI.push(context, Routes.registerPage);
        } else {
          UI.toast("Error");
        }

        // UI.pushReplaceAll(context, Routes.phoneNumber);
      } else if (res['key'] == 2) {
        UI.toast(res['value']);
      }
    } else {
      UI.toast(lang.translate("Invalid Input").toUpperCase());
    }
  }




}
