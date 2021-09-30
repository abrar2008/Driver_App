import 'package:EfendimDriverApp/core/preference/preference.dart';
import 'package:EfendimDriverApp/ui/routes%20copy/route_new.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:EfendimDriverApp/core/localizations/global_translations.dart';
import 'package:permission_handler/permission_handler.dart';

class Permessions {
  static Future<PermissionStatus> getLocationPerm(BuildContext context) async {
    final permession = await Permission.location.request();

    if (!permession.isGranted && !permession.isPermanentlyDenied) {
      // final locale = AppLocalizations.of(context);

      final action = await showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            return Dialog(
              child: Container(
                height: 500,
                width: 400,
                padding: EdgeInsets.all(4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>
                  [
                    Lottie.asset('assets/animation/location-permission.json'),

                    Text("Allow Location",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 24)),

                    SizedBox(
                      height: 10,),


                    Text("You can't take orders without location permission",
                        maxLines: 2, textAlign: TextAlign.center, style: TextStyle(fontSize: 16, )),

                    SizedBox(
                        height: 10),

                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text('Ok, lets do it',
                        style: TextStyle(color: Colors.white, fontSize: 18),


                      ),
                    ),



                    TextButton(
                      onPressed: () {Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=> Routes.allTasks));} ,
                      child: Text(
                        'cancel',
                        style: TextStyle(color: Colors.grey[400], fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            );
          });

      if (action) return await getLocationPerm(context) ?? false;



    }
    Preference.setString('locationPer', 'true');
    return permession;

  }
  //get cam per shows dialog if rejected!!
  // static Future<bool> getCamPerm(BuildContext context) async {
  //   await PermissionHandler().requestPermissions([PermissionGroup.camera]);
  //   final permissionStatus =
  //       await PermissionHandler().checkPermissionStatus(PermissionGroup.camera);

  //   if (permissionStatus.value != 2) {
  //     final locale = AppLocalizations.of(context);

  //     final action = await UI.dialog(
  //             context: context,
  //             child: Icon(Icons.camera, size: 44),
  //             title: locale.get("Permission denied") ?? "Permission denied",
  //             accept: true,
  //             msg: locale.get("Camera denied") ?? "Camera denied",
  //             cancelMsg: locale.tr('cancel'),
  //             acceptMsg: locale.tr('try again')) ??
  //         false;
  //     if (action) return getCamPerm(context) ?? false;
  //     return false;
  //   }
  //   return true;
  // }

  // static Future<bool> getStoragePerm(BuildContext context) async {
  //   await PermissionHandler().requestPermissions(
  //       [PermissionGroup.storage, PermissionGroup.mediaLibrary]);
  //   final permissionStatus1 = await PermissionHandler()
  //       .checkPermissionStatus(PermissionGroup.storage);
  //   final permissionStatus2 = await PermissionHandler()
  //       .checkPermissionStatus(PermissionGroup.mediaLibrary);

  //   if (permissionStatus2.value != 2 || permissionStatus1.value != 2) {
  //     final locale = AppLocalizations.of(context);

  //     final action = await UI.dialog(
  //             context: context,
  //             child: Icon(Icons.storage, size: 44),
  //             title: locale.tr("permission denied"),
  //             accept: true,
  //             // msg: locale.tr("camera denied"),
  //             cancelMsg: locale.tr('cancel'),
  //             acceptMsg: locale.tr('try again')) ??
  //         false;
  //     if (action) return getStoragePerm(context) ?? false;
  //     return false;
  //   }
  //   return true;
  // }
}
