import 'package:EfendimDriverApp/ui/Components/map_type_button.dart';
import 'package:EfendimDriverApp/ui/Components/maps_util.dart';
import 'package:EfendimDriverApp/ui/Components/my_location_button.dart';
import 'package:base_notifier/base_notifier.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_utils/ui_utils.dart';
import 'package:EfendimDriverApp/core/api/http_api.dart';
import 'package:EfendimDriverApp/core/api/api.dart';
import 'package:EfendimDriverApp/core/auth/authentication_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class GoogleMapsWidget extends StatelessWidget {
  final double width, heigth;
  Position position, destination;
  final Set<Marker> markers;
  final Function(LatLng) onTap;
  final Set<Polyline> polylines;
  final bool usePolylines;
  final bool isCustomMarker;
  BitmapDescriptor dropOffIcon;

  GoogleMapsWidget(
      {this.width,
      this.heigth,
      this.position,
      this.destination,
      this.markers,
      this.onTap,
      this.isCustomMarker = false,
      this.usePolylines = false,
      this.polylines});

  @override
  Widget build(BuildContext context) {
    position ??= Position(latitude: 39.0100619, longitude: 39.6671578);
    destination ??= Position(latitude: 39.0100619, longitude: 39.6671578);
    return FocusWidget(
        child: Scaffold(
            body: BaseWidget<GoogleMapsWidgetModel>(
                //initState: (m) => WidgetsBinding.instance.addPostFrameCallback((_) => m.initializeProfileData()),
                model: GoogleMapsWidgetModel(
                    api: Provider.of<Api>(context),
                    auth: Provider.of(context),
                    destination: destination,
                    context: context),
                builder: (context, model, child) {
                  return Container(
                      width: width ?? ScreenUtil.screenWidthDp,
                      height: heigth ?? ScreenUtil.screenHeightDp,
                      child: Stack(
                        children: [
                          GoogleMap(
                            buildingsEnabled: true,
                            myLocationButtonEnabled: false,
                            zoomControlsEnabled: false,
                            myLocationEnabled: true,
                            mapType: model.mapType,
                            mapToolbarEnabled: true,
                            initialCameraPosition: CameraPosition(
                              target:
                                  LatLng(position.latitude, position.longitude),
                              zoom: 16,
                            ),
                            onTap: onTap,
                            polylines: polylines,
                            onMapCreated: (GoogleMapController controller) {
                              model.mapsController = controller;
                              final p = CameraPosition(
                                  target: LatLng(
                                      position.latitude, position.longitude),
                                  zoom: 14.4746);
                              controller.animateCamera(
                                  CameraUpdate.newCameraPosition(p));
                              model.setState();
                              print("usePolylines..$usePolylines");
                              if (usePolylines) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  // this becuase we want to wait until maps already finished its layout
                                  // code that moves the camera
                                  /* controller.animateCamera(
                                    CameraUpdate.newLatLngBounds(
                                        model._bounds(markers), 50));*/
                                });
                              }
                            },
                            markers: markers,
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
//              margin: EdgeInsets.all(16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: MapTypeButton(
                                      mapType: model.mapType,
                                      onMapTypeChanged: (MapType mapType) {
                                        print("maptype..$mapType");
                                        model.updateMapType(mapType);
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: MyLocationButton(
                                      onTap: () {
                                        List<LatLng> temp = [];
                                        markers.forEach((element) {
                                          temp.add(element.position);
                                        });
                                        if (temp.isNotEmpty) {
                                          LatLngBounds bound =
                                              boundsFromLatLngList(temp);
                                          model.mapsController.animateCamera(
                                              CameraUpdate.newLatLngBounds(
                                                  bound, 64));
                                        }
                                        model.fullView = false;
                                      },
                                      iconData: Icons.zoom_out_map,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ));
                })));
  }
}

class GoogleMapsWidgetModel extends BaseNotifier {
  final HttpApi api;
  final AuthenticationService auth;
  final BuildContext context;

  GoogleMapController mapsController;
  MapType mapType = MapType.normal;
  bool fullView = false;

  Position destination;

  GoogleMapsWidgetModel(
      {NotifierState state,
      this.api,
      this.auth,
      this.context,
      this.destination})
      : super(state: state);

  LatLngBounds _bounds(Set<Marker> markers) {
    if (markers == null || markers.isEmpty) return null;
    return _createBounds(markers.map((m) => m.position).toList());
  }

  updateMapType(MapType mapTypeStyle) {
    mapType = mapTypeStyle;
    setState();
  }

  LatLngBounds _createBounds(List<LatLng> positions) {
    final southwestLat = positions.map((p) => p.latitude).reduce(
        (value, element) => value < element ? value : element); // smallest
    final southwestLon = positions
        .map((p) => p.longitude)
        .reduce((value, element) => value < element ? value : element);
    final northeastLat = positions.map((p) => p.latitude).reduce(
        (value, element) => value > element ? value : element); // biggest
    final northeastLon = positions
        .map((p) => p.longitude)
        .reduce((value, element) => value > element ? value : element);
    return LatLngBounds(
        southwest: LatLng(southwestLat, southwestLon),
        northeast: LatLng(northeastLat, northeastLon));
  }
}
