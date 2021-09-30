import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:EfendimDriverApp/ui/Themes/colors.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
//app theme

final ThemeData darkTheme = ThemeData.dark().copyWith(
  //fontFamily: 'OpenSans',
  scaffoldBackgroundColor: kMainDarkColor,
  secondaryHeaderColor: kWhiteColor,
  primaryColor: kMainColor,
  primaryColorDark: kMainDarkColor,
  bottomAppBarColor: kMainTextColor,
  dividerColor: Color(0x1f000000),
  disabledColor: kDisabledColor,
  buttonColor: kMainColor,
  cardColor: kCardBackgroundDarkColor,
  hintColor: kLightTextColor,
  cursorColor: kMainColor,
  indicatorColor: kMainColor,
  accentColor: kAccentColor,
  iconTheme: IconThemeData(color: kIconDarkColor),
  floatingActionButtonTheme: FloatingActionButtonThemeData(foregroundColor: kFloatingButtonColor, backgroundColor: kFloatingButtonColor),

  bottomAppBarTheme: BottomAppBarTheme(color: kMainColor),
  buttonTheme: ButtonThemeData(
    textTheme: ButtonTextTheme.normal,
    height: 33,
    padding: EdgeInsets.only(top: 0, bottom: 0, left: 16, right: 16),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
        side: BorderSide(color: kMainColor)),
    alignedDropdown: false,
    buttonColor: kMainColor,
    disabledColor: kDisabledColor,
  ),
  appBarTheme: AppBarTheme(
    //backgroundColor: kMainDarkColor,
    color: kMainDarkColor,
    elevation: 0.0,
  ),
  //text theme which contains all text styles
  textTheme: GoogleFonts.openSansTextTheme().copyWith(
    //text style of 'Delivering almost everything' at phone_number page
    bodyText1: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18.3,
    ),

    //text style of 'Everything.' at phone_number page
    bodyText2: TextStyle(
      fontSize: 18.3,
      letterSpacing: 1.0,
      color: kDisabledColor,
    ),

    //text style of button at phone_number page
    button: TextStyle(
      fontSize: 13.3,
      color: kIconColor,
    ),

    //text style of 'Got Delivered' at home page
    headline4: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 16.7,
    ),

    //text style of we'll send verification code at register page
    headline6: TextStyle(
      color: kLightTextColor,
      fontSize: 13.3,
    ),

    //text style of 'everything you need' at home page
    headline5: TextStyle(
      color: kDisabledColor,
      fontSize: 20.0,
      letterSpacing: 0.5,
    ),

    //text entry text style
    caption: TextStyle(
      color: kLightTextColor,
      fontSize: 13.3,
    ),

    overline: TextStyle(color: kLightTextColor, letterSpacing: 0.2),

    //text style of titles of card at home page
    headline2: TextStyle(
      color: Colors.white,
      fontSize: 12.0,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.5,
    ),
    subtitle2: TextStyle(
      color: kLightTextColor,
      fontSize: 15.0,
    ),
  ),
);

final ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: kGrey350Color,
  secondaryHeaderColor: kDarkTextColor,
  primaryColor: kMainColor,
  primarySwatch: Colors.red,
  bottomAppBarColor: kWhiteColor,
  dividerColor: Color(0x1f000000),
  disabledColor: kDisabledColor,
  buttonColor: kMainColor,
  cursorColor: kMainColor,
  cardColor: kCardBackgroundColor,
  hintColor: kLightTextColor,
  indicatorColor: kMainColor,
  accentColor: kAccentColor,
  bottomAppBarTheme: BottomAppBarTheme(color: kMainColor),
  iconTheme: IconThemeData(color: kIconColor),
  buttonTheme: ButtonThemeData(
    textTheme: ButtonTextTheme.normal,
    height: 33,
    padding: EdgeInsets.only(top: 0, bottom: 0, left: 16, right: 16),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
        side: BorderSide(color: kMainColor)),
    alignedDropdown: false,
    buttonColor: kMainColor,
    disabledColor: kDisabledColor,
  ),
  appBarTheme: AppBarTheme(
    color: kMainColor,
    elevation: 0.0,
  ),
  //text theme which contains all text styles
  textTheme: GoogleFonts.cairoTextTheme().copyWith(
    //text style of 'Delivering almost everything' at phone_number page
    bodyText1: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18.3,
      color: kMainTextColor
    ),

    //text style of 'Everything.' at phone_number page
    bodyText2: TextStyle(
      fontSize: 18.3,
      letterSpacing: 1.0,
      color: kDisabledColor,
    ),

    //text style of button at phone_number page
    button: TextStyle(
      fontSize: 13.3,
      color: kIconColor,
    ),

    //text style of 'Got Delivered' at home page
    headline4: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 16.7,
    ),

    //text style of we'll send verification code at register page
    headline6: TextStyle(
      color: kDarkTextColor,
      fontSize: 13.3,
    ),

    //text style of 'everything you need' at home page
    headline5: TextStyle(
      color: kDisabledColor,
      fontSize: 20.0,
      letterSpacing: 0.5,
    ),

    //text entry text style
    caption: TextStyle(
      color: kDarkTextColor,
      fontSize: 13.3,
    ),

    overline: TextStyle(color: kLightTextColor, letterSpacing: 0.2),

    //text style of titles of card at home page
    headline2: TextStyle(
      color: kMainTextColor,
      fontSize: 12.0,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.5,
    ),
    subtitle2: TextStyle(
      color: kDarkTextColor,
      fontSize: 15.0,
    ),
  ),
);

//text style of continue bottom bar
final TextStyle bottomBarTextStyle = GoogleFonts.cairo().copyWith(
  fontSize: 15.0,
  color: kWhiteColor,
  fontWeight: FontWeight.w400,
);

final TextStyle listTitleTextStyle = GoogleFonts.cairo().copyWith(
  fontSize: 16.7,
  fontWeight: FontWeight.bold,
  color: kMainColor,
);
