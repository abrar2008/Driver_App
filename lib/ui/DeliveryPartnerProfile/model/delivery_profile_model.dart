import 'dart:io';

import 'package:EfendimDriverApp/ui/routes%20copy/route_new.dart';
import 'package:base_notifier/base_notifier.dart';
import 'package:flutter/material.dart';
import 'package:EfendimDriverApp/core/api/http_api.dart';
import 'package:EfendimDriverApp/core/auth/authentication_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ui_utils/ui_utils.dart';
import 'package:EfendimDriverApp/core/constants/constants.dart';
import 'dart:convert';
import 'package:reactive_forms/reactive_forms.dart';

enum ImageType { PROFILE, LICENSE, GOVERNMENT_ID }

class DeliveryProfilePageModel extends BaseNotifier {
  final HttpApi api;
  final AuthenticationService auth;
  final BuildContext context;

  FormGroup form;
  List types = [];

  final String baseUrl = "https://efendim.biz/upload/driver/";

  DeliveryProfilePageModel(
      {NotifierState state, this.api, this.auth, this.context})
      : super(state: state) {
    // get document status
    getDocumentStatus();

    // make a list of transport types
    auth.userProfile.details.transportList.toJson().forEach((key, value)
    {
      print(value);
      types.add({'key': key, 'value': value});
    });

    // put image path into path to show it in ui
    path['value'] = auth.userProfile.details.profilePhoto;

    // create a form group
    form = FormGroup(
        {
      'name': FormControl<String>(value: auth.userProfile.details.fullName),

      'first_name': FormControl<String>(
          value: auth.userProfile.details.fullName.split(" ")[0]),

      'last_name': FormControl<String>(
          value: auth.userProfile.details.fullName.split(" ")[1]),

      'email': FormControl<String>(value: auth.userProfile.details.email),

      'team_name': FormControl<String>(value: auth.userProfile.details.teamName),

      'licence_plate': FormControl<String>(value: auth.userProfile.details.licencePlate),

      'color': FormControl<String>(value: auth.userProfile.details.color),

      'phone': FormControl<String>(value: auth.userProfile.details.phone),

      'api_key': FormControl<String>(value: Constants.API_KEY),

      'app_version': FormControl<String>(value: Constants.APP_VERSION),

      'token': FormControl<String>(value: auth.user.details.token),

      'current_pass': FormControl<String>(value: " "),

      //validators: [Validators.required]),
      'new_pass': FormControl<String>(value: " "),

      'confirm_pass': FormControl<String>(value: " "),

      'transport_type_id':
          FormControl<String>(value: auth.userProfile.details.transportTypeId),

      'transport_description':
          FormControl<String>(value: auth.userProfile.details.transportTypeId2),

    },
        validators:
        [
      Validators.mustMatch('new_pass', 'confirm_pass')
    ]
    );
  }

  bool uploading = false;
  File choosedImage;

  Map<String, String> path = {'key': '', 'value': ''};
  Map<String, String> license = {'key': '', 'value': ''};
  Map<String, String> governmentID = {'key': '', 'value': ''};

  uploadPhoto(ImageType type) async
  {
    final body = {
      'token': auth.user.details.token,
      'app_version': Constants.APP_VERSION,
      'api_key': Constants.API_KEY,
    };

    uploading = true;
    setState();

    try
    {
      final imageFile =
          await ImagePicker().getImage(source: ImageSource.gallery);

      // FilePickerCross imageFile = await FilePickerCross.importFromStorage();
      // to do make user upload specific size

      if (imageFile != null) {
        choosedImage = File(imageFile.path);

        // upload image
        final res = await api.uploadImage(context, choosedImage,
            body: body, type: type);
        res.fold((e) => UI.toast(e.toString()), (data) {
          // res like => 1|Upload Successful|https://efe...
          String x = data;
          var y = x.split("|");
          if (y[0] == '1') {
            // success
            UI.toast(y[1]);

            switch (type) {
              case ImageType.LICENSE:
                license['key'] = 'uploaded';
                license['value'] = y[2];
                // form.control('license_plate').updateValue(license);
                break;
              case ImageType.PROFILE:
                path['key'] = 'uploaded';
                path['value'] = y[2];
                break;
              case ImageType.GOVERNMENT_ID:
                governmentID['key'] = 'uploaded';
                governmentID['value'] = y[2];
                break;
            }
          } else {
            UI.toast(y[1]);
            // path = null;
          }
        });
        uploading = false;
        setState();
      } else {
        uploading = false;
        setState();
      }
    } catch (e) {
      print(e.toString());
      // setIdle();
      uploading = false;
      setState();
      return;
    }
  }

  getDocumentStatus() async
  {
    setBusy();

    final body =
    {
      'token': auth.user.details.token,
      'app_version': Constants.APP_VERSION,
      'api_key': Constants.API_KEY,
    };

    final res = await api.getDocumentStatus(context, body: body);
    res.fold((e)
    {
      UI.toast(e.toString());
      setError();
    }, (data) {
      // convert data to json
      data = json.decode(data);

      // status and value for government ID
      governmentID['key'] = data['government_id_status'];
      governmentID['value'] = data['government_id'];

      // status and value for license
      license['key'] = data['license_status'];
      license['value'] = data['license'];

      setIdle();
    });
  }

  void updateProfile({isPop = true}) async
  {
    Map body = form.value;
    // body.removeWhere((key, value) => value == null || value == '');

    print("body$body");

    setBusy();

    final res = await api.updateProfile(context, body: body);
    res.fold((e)
    {
      UI.toast(e.toString());
      setIdle();
    }, (data) async
    {
      data = json.decode(data);
      if (data['code'] == 1)
      {
        await auth.getUserProfile(context);
        setIdle();
        if (isPop)
          Navigator.pop(context);
        else
          UI.pushReplaceAll(context, Routes.allTasks);
      }
      setIdle();
    });
  }
}
