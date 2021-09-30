import 'dart:developer';
import 'dart:typed_data';

import 'package:EfendimDriverApp/core/models/all_tasks_model.dart';
import 'package:EfendimDriverApp/core/models/order_detail_info.dart';
import 'package:base_notifier/base_notifier.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:EfendimDriverApp/core/api/http_api.dart';
import 'package:EfendimDriverApp/core/auth/authentication_service.dart';
import 'package:EfendimDriverApp/core/models/new_order.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:EfendimDriverApp/core/permession/permessions.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:EfendimDriverApp/core/constants/constants.dart';
import 'dart:convert';
import 'package:EfendimDriverApp/ui/routes%20copy/route_new.dart';
import 'package:ui_utils/ui_utils.dart';
import 'dart:convert' as JSON;
import 'dart:ui' as ui;

import 'package:url_launcher/url_launcher.dart';

enum OrderStatus {
  FAILED,
  CANCELED,
  DECLINED,
  ACKNOWLEDGED,
  STARTED,
  INPROGRESS,
  SUCCESSFUL
}

extension OrderStatusExtension on OrderStatus {
  String get status {
    switch (this) {
      case OrderStatus.FAILED:
        return 'failed';
      case OrderStatus.CANCELED:
        return 'cancelled';
      case OrderStatus.DECLINED:
        return 'declined';
      case OrderStatus.ACKNOWLEDGED:
        return 'acknowledged';
      case OrderStatus.STARTED:
        return 'started';
      case OrderStatus.INPROGRESS:
        return 'inProgress';
      case OrderStatus.SUCCESSFUL:
        return 'successful';

      default:
        return null;
    }
  }
}

class NewDeliveryPageModel extends BaseNotifier {
  final HttpApi api;
  final AuthenticationService auth;
  final BuildContext context;

  final Details newTask;
  OrderDetailModel orderDetailInfo;

  String errorMsg;
  NewOrderModel newOrderModel;
  AllTasksModel tasksModel;

  Set<Marker> markers = Set();
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};
  BitmapDescriptor driverIcon;
  BitmapDescriptor merchantIcon;
  BitmapDescriptor customerIcon;

  // Default location : turkia
  Position currentPosition =
      Position(latitude: 39.0100619, longitude: 39.6671578);
  GoogleMapController mapsController;

  bool isAccepted = true;
  bool isPicked = false;
  bool isDelivered = false;
  bool changingOrderStatus = false;

  bool waiting = false;

  bool isStarted = false;
  String distance = "0";
  String errorString;

  String time = "0";

  NewDeliveryPageModel(
      {NotifierState state, this.api, this.auth, this.context, this.newTask})
      : super(state: state) {
    print("order status..${newTask.status}");
    if (newTask.status == 'acknowledged') {
      waiting = true;
    } else if (newTask.status == 'assigned') {
      waiting = true;
      isAccepted = true;
    } else if (newTask.status == 'started') {
      isStarted = true;
      isAccepted = true;
    } else if (newTask.status == 'inProgress') {
      isAccepted = true;
      isPicked = true;
    }
    getLocation();
    // getNewTask();
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  getAllTask() async {
    // selection 0 => Penmding tasks
    // selection 1 => Completed tasks
    //

    setBusy();
    final body = {
      'app_version': Constants.APP_VERSION,
      'token': auth.user.details.token,
      'api_key': Constants.API_KEY,
      'lang': Constants.APP_LANGUAGE,
      'task_type': 'pending'
    };
    final res = await api.getAllTasks(context, body: body);

    res.fold((e) {
      // something error
      errorString = e.toString();
      UI.toast(e.toString());
    }, (data) {
      // convert data to json
      data = json.decode(data);

      if ((data['code'] == 2) && (data['msg'] == "No task for the day")) {
        tasksModel = AllTasksModel.fromJson(data);
        setIdle();
      } else
      // check if code == 2 that means something is error
      if (data['code'] == 2) {
        print("errrrr");
        setError();
        errorString = data['msg'];
      } else {
        // map json to model
        tasksModel = AllTasksModel.fromJson(data);
        setIdle();
      }
    });
  }

  void addMarker() {
    markers.add(Marker(
        markerId: MarkerId(newOrderModel.details.orderId),
        position: LatLng(double.tryParse(newOrderModel.details.dropoffLat),
            double.tryParse(newOrderModel.details.dropoffLng)),
        infoWindow: InfoWindow(title: newOrderModel.details.customerName)));
  }

  getLocation() async {
    Uint8List startMarker =
        await getBytesFromAsset("assets/images/map_home.png", 86);
    customerIcon = BitmapDescriptor.fromBytes(startMarker);

    Uint8List endMarker =
        await getBytesFromAsset("assets/images/map_truck.png", 86);
    driverIcon = BitmapDescriptor.fromBytes(endMarker);
    Uint8List merchMarker =
        await getBytesFromAsset("assets/images/map_merchant.png", 86);
    merchantIcon = BitmapDescriptor.fromBytes(merchMarker);
    log("newtask data..${jsonEncode(newTask)}");
    setBusy();
    getOrderDetails(newTask.orderId);
    final PermissionStatus res = await Permessions.getLocationPerm(context);
    if (res.isGranted) {
      currentPosition = await Geolocator.getCurrentPosition();
      if (currentPosition != null &&
          currentPosition.latitude != null &&
          currentPosition.longitude != null) {
        // Set marker on current location
        print("merchngetname..${newTask.merchantName}");
        markers.add(Marker(
            icon: driverIcon,
            markerId: MarkerId(auth.user?.details?.token ?? " "),
            position:
                LatLng(currentPosition.latitude, currentPosition.longitude),
            infoWindow: InfoWindow(title: newTask.merchantName)));
        if (newTask.dropoffLng != null &&
            newTask.dropoffLng.isNotEmpty &&
            newTask.dropoffLat != null &&
            newTask.dropoffLat.isNotEmpty)
          markers.add(Marker(
              icon: merchantIcon,
              markerId: MarkerId(newTask.taskId ?? " "),
              position: LatLng(double.tryParse(newTask.dropoffLat),
                  double.tryParse(newTask.dropoffLng)),
              infoWindow: InfoWindow(title: newTask.merchantName)));
        if (newTask.taskLat != null &&
            newTask.taskLat.isNotEmpty &&
            newTask.taskLng != null &&
            newTask.taskLng.isNotEmpty)
          markers.add(Marker(
              icon: customerIcon,
              markerId: MarkerId(auth.user?.details?.token ?? " "),
              position: LatLng(double.tryParse(newTask.taskLat),
                  double.tryParse(newTask.taskLng)),
              infoWindow: InfoWindow(
                title: newTask.customerName,
              )));

        // await _getPolyline();
        if ((currentPosition.latitude == "") ||
            (currentPosition.longitude == "") ||
            (newTask.dropoffLat == "") ||
            (newTask.dropoffLng == "")) {
          distance = "Not defined";
        } else {
          await getdis();
        }
        setIdle();
      } else {
        setIdle();
      }
      /*  else {
        UI.toast("You must enable access location");
        setError();
      } */
    }
  }

  launchURL() async {
    var url =
        'https://www.google.com/maps/dir/?api=1&origin=${newTask.dropoffLat},${newTask.dropoffLng}&destination=${newTask.taskLat},${newTask.taskLng}&travelmode=driving&dir_action=navigate';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

//   void setSourceAndDestinationIcons() async {
//    sourceIcon = await BitmapDescriptor.fromAssetImage(
//       ImageConfiguration(devicePixelRatio: 2.5),
//       ‘assets/driving_pin.png’);
//    destinationIcon = await BitmapDescriptor.fromAssetImage(
//       ImageConfiguration(devicePixelRatio: 2.5),
//       ‘assets/destination_map_marker.png’);
// }
//
  Future<void> _getPolyline() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      Constants.GOOGLE_MAPS_API_KEY,
      PointLatLng(currentPosition.latitude, currentPosition.longitude),
      PointLatLng(double.tryParse(newTask.dropoffLat),
          double.tryParse(newTask.dropoffLng)),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print("error for polyline..${result.errorMessage}");
    }
    _addPolyLine(polylineCoordinates);
  }

  Future<void> getdis() async {
    print(currentPosition.latitude);
    print(currentPosition.longitude);

    print(newTask.dropoffLat);

    print(newTask.dropoffLng);

    double distance1 = Geolocator.distanceBetween(
      currentPosition.latitude,
      currentPosition.longitude,
      double.tryParse(newTask.dropoffLat),
      double.tryParse(newTask.dropoffLng),
    );
    //   Dio dio = new Dio();
    //  Response response = await dio.get(
    //    "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=${currentPosition.latitude},${currentPosition.longitude}&destinations=${newTask.dropoffLat},${newTask.dropoffLng}&key=${Constants.GOOGLE_MAPS_API_KEY}");
    // print("ditance,,,$response");
    // if (response.data != null && response.data['row'] != null) {
    //   time = response.data["rows"][0]["elements"][0]["distance"]["text"];
    // }
    // print("time : $time");
    distance = (distance1 / 1000).toStringAsFixed(2);
    setState();
  }

  _addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      points: polylineCoordinates,
      color: Colors.red,
      width: 3,
    );
    polylines[id] = polyline;
    setState();
  }

  changeStatusOrder({OrderStatus status}) async {
    final body = {
      'app_version': Constants.APP_VERSION,
      'token': auth.user.details.token,
      'api_key': Constants.API_KEY,
      'task_id': newTask.taskId,
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
      log("data..$data");
      data = json.decode(data);

      if (data['msg'] == 'OK') {
        newTask.status = data["details"]["status_raw"];
        // Changed successfully
        switch (status) {
          case OrderStatus.STARTED:
            isStarted = true;
            waiting = false;
            getAllTask();
            break;
          case OrderStatus.ACKNOWLEDGED:
            waiting = true;
            getAllTask();
            break;
          case OrderStatus.INPROGRESS:
            isPicked = true;
            isStarted = false;
            waiting = false;
            getAllTask();
            break;
          case OrderStatus.SUCCESSFUL:
            isDelivered = true;
            UI.push(context, Routes.deliverySuccessful, replace: true);
            break;
          default:
        }
      }
      changingOrderStatus = false;
      setState();
    });
    // setIdle();
  }

  getOrderDetails(orderId) async {
    // Make body
    log("getOrderDetails orderId..$orderId");
    final body = {
      'api_key': Constants.API_KEY,
      'lang': Constants.APP_LANGUAGE,
      'app_version': Constants.APP_VERSION,
      'token': auth.user.details.token,
      'order_id': orderId.toString(),
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
      log("orderderails..$res");
      if (data['code'] == 2) {
        errorMsg = data['msg'];
        setError();
      } else {
        orderDetailInfo = OrderDetailModel.fromJson(data);
      }
    });
  }
}
