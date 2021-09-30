import 'package:flutter/material.dart';
import 'package:EfendimDriverApp/ui/Auth/MobileNumber/UI/phone_number.dart';
import 'package:EfendimDriverApp/ui/Auth/Registration/UI/register_page.dart';
import 'package:EfendimDriverApp/ui/Auth/Verification/UI/verification_page.dart';
import 'package:EfendimDriverApp/ui/Auth/social.dart';
import 'package:EfendimDriverApp/ui/Routes/routes.dart';
import 'package:EfendimDriverApp/ui/routes%20copy/route_new.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class LoginRoutes {
  static const String loginRoot = 'login/';
  static const String social = 'login/social';
  static const String registration = 'login/registration';
  static const String verification = 'login/verification';
}

class LoginData {
  final String phoneNumber;
  final String name;
  final String email;

  LoginData(this.phoneNumber, this.name, this.email);
}

class LoginNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var canPop = navigatorKey.currentState.canPop();
        if (canPop) {
          navigatorKey.currentState.pop();
        }
        return !canPop;
      },
      child: Navigator(
        key: navigatorKey,
        // initialRoute: LoginRoutes.loginRoot,
        // initialRoute: Routes.pho,
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case LoginRoutes.loginRoot:
              builder = (BuildContext _) => PhoneNumber();
              break;
            case LoginRoutes.social:
              builder = (BuildContext _) => SocialLogIn();
              break;
            case LoginRoutes.registration:
              builder = (BuildContext _) => RegisterPage();
              break;
            case LoginRoutes.verification:

              break;
          }
          return MaterialPageRoute(builder: builder, settings: settings);
        },
        onPopPage: (Route<dynamic> route, dynamic result) {
          return route.didPop(result);
        },
      ),
    );
  }
}
