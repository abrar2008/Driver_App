import 'package:EfendimDriverApp/core/preference/preference.dart';
import 'package:base_notifier/base_notifier.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:EfendimDriverApp/core/api/http_api.dart';
import 'package:EfendimDriverApp/core/auth/authentication_service.dart';
import 'package:EfendimDriverApp/core/permession/permessions.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:EfendimDriverApp/core/models/new_order.dart';
import 'package:EfendimDriverApp/core/constants/constants.dart';
import 'package:ui_utils/ui_utils.dart';
import 'dart:convert';

enum OrderStatus {
  STARTED,

}

extension OrderStatusExtension on OrderStatus {
  String get status {
    switch (this) {
      case OrderStatus.STARTED:
        return 'started';

      default:
        return null;
    }
  }
}

class AccountPagePageModel extends BaseNotifier {
  final HttpApi api;
  final AuthenticationService auth;
  final BuildContext context;

  NewOrderModel newOrderModel;

  bool gettingProfile = false;
  bool gettingProfileError = false;

  String errorMsg = '';

  bool isAccepted = false;
  bool changingOrderStatus = false;
  bool offline = false;
  bool accountstatus = false;

  // Default location : turkia
  Position currentPosition =
      Position(latitude: 39.0100619, longitude: 39.6671578);
  GoogleMapController mapsController;

  final Set<Marker> markers = Set();

  AccountPagePageModel({NotifierState state, this.api, this.auth, this.context})
      : super(state: state) {
    getProfile();
    // getLocation();
    getNewTask();
  }

  getNewTask() async {
    setBusy();
    var ddd = Preference.getString(PrefKeys.status);

    accountstatus = (ddd != 'active');
    print("accountstatus :$accountstatus");
    print("ddd :$ddd");

    // await getLocation();
    // Make body of request1 (which will get the ID)
    final body = {
      'api_key': Constants.API_KEY,
      'lang': Constants.APP_LANGUAGE,
      'app_version': Constants.APP_VERSION,
      'token': auth.user.details.token,
      'task_type': 'pending'
    };

    // fetch new task
    final res = await api.getNewTask(context, body: body);
    res.fold((e) {
      // Something is wrong with server
      errorMsg = e.toString();
      setError();
    }, (data) async {
      // data is here
      //
      // convert data to json
      data = json.decode(data);

      if (data['code'] == 1) {
        newOrderModel = NewOrderModel.fromJson(data);

        // add marker to order ppoint
        // addMarker();

        // // get poly lines
        // await _getPolyline();

        setIdle();
      } else {
        errorMsg = data['msg'];
        setError();
      }
    });
  }

  getLocation() async {
    // setBusy();
    final PermissionStatus res = await Permessions.getLocationPerm(context);
    if (res.isGranted) {
      currentPosition = await Geolocator.getCurrentPosition();
      if (currentPosition != null &&
          currentPosition.latitude != null &&
          currentPosition.longitude != null) {
        // Set marker on current location
        markers.add(Marker(
          markerId: MarkerId(auth.user?.details?.token ?? " "),
          position: LatLng(currentPosition.latitude, currentPosition.longitude),
        ));

        // mapsController.animateCamera(CameraUpdate.newCameraPosition(
        //     CameraPosition(
        //         target:
        //             LatLng(currentPosition.latitude, currentPosition.longitude),
        //         zoom: 14.4746)));

        setState();
      }
      /*  else {
        UI.toast("You must enable access location");
        setError();
      } */
    }
  }

  void getProfile() async {
    await auth.loadUser();
    gettingProfile = true;
    setState();
    if (await auth.getUserProfile(
      context,
    )) {
      gettingProfile = false;
      setState();
    } else {
      gettingProfile = false;
      gettingProfileError = true;
      setState();
    }
  }

  changeStatusOrder({OrderStatus status}) async {
    final body = {
      'app_version': Constants.APP_VERSION,
      'token': auth.user.details.token,
      'api_key': Constants.API_KEY,
      'task_id': newOrderModel.details.taskId,
      'status_raw': status.status
    };

    // setBusy();
    changingOrderStatus = true;
    setState();

    final res = await api.changeOrderStatus(context, body: body);
    res.fold((e) {
      UI.toast(e.toString());
      changingOrderStatus = false;
      setState();
    }, (data) {
      // covert data to json
      data = json.decode(data);

      if (data['msg'] == 'OK') {
        // Changed successfully
        switch (status) {
          case OrderStatus.STARTED:
            isAccepted = true;
            break;

          default:
        }
      }
      changingOrderStatus = false;
      setState();
    });
    // setIdle();
  }

  changeDutyStatue({bool isOnline}) async {
    final body = {
      'app_version': Constants.APP_VERSION,
      'token': auth.user.details.token,
      'api_key': Constants.API_KEY,
      'onduty': isOnline ? "1" : "0"
    };
    final res = await api.changeDutyStatus(context, body: body);
    res.fold((e) {
      UI.toast(e.toString());
    }, (data) {
      // covert data to json
      data = json.decode(data);

      if (data['msg'] == 'OK') {
        // Changed successfully
        offline = !isOnline;
      }
      setState();
    });
  }
}
