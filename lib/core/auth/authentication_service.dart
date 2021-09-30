import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:EfendimDriverApp/core/api/http_api.dart';
import 'package:EfendimDriverApp/core/models/user.dart';
import 'package:EfendimDriverApp/core/models/profile.dart';
import 'package:EfendimDriverApp/core/preference/preference.dart';
import 'package:ui_utils/ui_utils.dart';
import 'package:EfendimDriverApp/core/constants/constants.dart';

class AuthenticationService {
  final HttpApi api;

  User _user;

  String status = "";
  User get user => _user;

  Profile _userProfile;
  Profile get userProfile => _userProfile;

  AuthenticationService({this.api}) {
    // print("hello");
  }

  saveUser({User user}) {
    Preference.setString(PrefKeys.status, status);

    Preference.setBool(PrefKeys.userLogged, true);

    Preference.setBool(PrefKeys.userLogged, true);
    Preference.setString(PrefKeys.userData, json.encode(user.toJson()));
    Preference.setString(PrefKeys.token, user.details.token);
    _user = user;
  }

  Future<void> get signOut async {
    await Preference.remove(PrefKeys.userData);
    await Preference.remove(PrefKeys.userLogged);

    _user = null;
  }

  Future<void> loadUser() async {
    if (userLoged) {
      _user =
          User.fromJson(json.decode(Preference.getString(PrefKeys.userData)));
      // print('\n\n\n\n ${_user.user}');
      // Logger().i(_user.toJson());
      // print('\n\n\n\n');
    } else {
      print('\n\n\n\n There is no user saved');
    }
  }

  bool get userLoged => Preference.getBool(PrefKeys.userLogged) ?? false;

  signIn(BuildContext context,
      {Map<String, dynamic> body, @required bool withPhone}) async {
    Map finalRes = {'key': '', 'value': ''};
    var res = await api.signIn(context, body: body, withPhone: withPhone);
    res.fold((error) {
      finalRes['key'] = '0';
      finalRes['value'] = error.toString();
    }, (data) {
      // Convert raw text to json
      data = json.decode(data);

      finalRes['key'] = data['code'];
      finalRes['value'] = data['msg'];

      if (finalRes['key'] == 2)  {
        return finalRes;
      } else {
        status = data['details']["status"];
        print("status$status");

        _user = User.fromJson(data);
      }
    });

    if (user != null) {
      // save user
      saveUser(user: _user);
    }

    return finalRes;
  }

  signUp(BuildContext context, {Map<String, dynamic> body}) async {
    var res = await api.signUp(context, body: body);
    Map finalRes = {'key': '', 'value': ''};
    res.fold((error) {
      finalRes['key'] = '0';
      finalRes['value'] = error.toString();
    }, (data) {
      // Convert raw text to json
      data = json.decode(data);

      finalRes['key'] = data['code'];
      finalRes['value'] = data['msg'];
    });

    return finalRes;
  }

  Future<bool> updateUser(BuildContext context,
      {Map<String, dynamic> body}) async {
    // var res = await api.updateUser(context, body: body, userId: user.user.sId);

    // bool ress = false;

    // res.fold((error) {
    //   UI.toast(error.toString());
    //   ress = false;
    // }, (data) {
    //   var newUserInfo = UserInfo.fromJson(data);
    //   user.user = newUserInfo;
    //   saveUser(user: user);
    //   ress = true;
    // });

    // return ress;
  }

  changePassword(BuildContext context, {Map<String, dynamic> body}) async {
    // var res =
    //     await api.changePassword(context, body: body, userId: user.user.sId);

    // bool ress = false;

    // res.fold((error) {
    //   UI.toast(error.toString());
    //   ress = false;
    // }, (data) {
    //   var newUserInfo = UserInfo.fromJson(data);
    //   user.user = newUserInfo;
    //   saveUser(user: user);
    //   ress = true;
    // });

    // return ress;
  }

  getUserProfile(BuildContext context) async {
    final Map<String, dynamic> body = {
      'app_version': Constants.APP_VERSION,
      'token': user.details.token,
      'api_key': Constants.API_KEY
    };
    var res = await api.getUserProfile(context, body: body);

    res.fold((error) => UI.toast(error.toString()), (data) {
      // Convert raw text to json
      data = json.decode(data);

      if (data['code'] == 2) return false;
      // Map the result to user object
      _userProfile = Profile.fromJson(data);
    });

    if (_userProfile != null) {
      // save user
      // saveUser(user: _user);

      // UI.toast("Success");
      return true;
    }

    return false;
  }

  getUserByID(context, {String id}) async {
    // var res = await api.getUserByUserId(context, userId: id);

    // User user;

    // res.fold(
    //     (error) => showGeneralDialog(
    //           context: context,
    //           barrierDismissible: true,
    //           barrierLabel: '',
    //           pageBuilder: (context, animation, secondaryAnimation) {},
    //           transitionBuilder: (context, anim1, anim2, child) =>
    //               Transform.scale(
    //                   scale: anim1.value,
    //                   child: Opacity(
    //                     opacity: anim1.value,
    //                     child: ErrorDialog(
    //                       error: error.toString(),
    //                     ),
    //                   )),
    //         ), (data) {
    //   user = User.fromJson(data);
    // });

    // if (user != null) {
    //   // save user
    //   saveUser(user: user);
    //   UI.toast("Success");
    //   return true;
    // }

    // return false;
  }

  updateFCM({fcm}) async {
    final Map<String, dynamic> body = {
      'app_version': Constants.APP_VERSION,
      'token': user.details.token,
      'api_key': Constants.API_KEY,
      'new_device_id': fcm
    };

    final res = await api.updateFCM(body: body);
    res.fold((e) => UI.toast(e.toString()), (data) {
      // convert data to json
      data = json.decode(data);
      if (data['msg'] == 'OK') {
        UI.toast("FCM update successfully");
      }
    });
  }

  // static handleAuthExpired({@required BuildContext context}) async {
  //   if (context != null) {
  //     try {
  //       await Preference.clear();

  //       String mac =
  //           await Provider.of<ConnectivityService>(context, listen: false)
  //               .getDeviceID();

  //       if (!Provider.of<AuthenticationService>(context, listen: false)
  //           .userLoged) {
  //         try {
  //           await Provider.of<AuthenticationService>(context, listen: false)
  //               .getUserToken(context, mac);

  //           Provider.of<CartService>(context, listen: false)?.cart = null;

  //           Provider.of<FavouriteService>(context, listen: false)?.favourites =
  //               null;

  //           Provider.of<CategoryService>(context, listen: false)
  //               .getCategories(context);

  //           Provider.of<HomePageService>(context, listen: false)
  //               .getHomePageItems(context);

  //           Provider.of<CartService>(context, listen: false)
  //               .setState(state: NotifierState.idle, notifyListener: false);
  //         } catch (e) {
  //           Logger().e('error in  method $e');
  //         }
  //       } else {
  //         try {
  //           Provider.of<InitService>(context, listen: false)
  //               .initServices(context);
  //         } catch (e) {
  //           Logger().e('error in  method $e');
  //         }
  //       }

  //       UI.pushReplaceAll(context, Routes.home);

  //       Logger().v('🦄session destroyed🦄');
  //     } catch (e) {
  //       Logger().v('🦄error while destroying session $e🦄');
  //     }
  //   }
  // }
}
