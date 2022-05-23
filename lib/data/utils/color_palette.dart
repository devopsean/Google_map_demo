import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColorPalette {
  ColorPalette._();
static const Color transparent = Colors.transparent;
  // LIGHT COLOURS

  static const Color lightBlue_1 = Color(0XFFdde6ff);
  static const Color lightBlue_2 = Color(0XFF2050d6);
  static const Color lightBlue_3 = Color(0xff4860AA);
  static const Color lightBlue = Color(0xffdef5fc);
  static const Color darkBlue_1 = Color(0xFF001F6D);
  static const Color darkBlue_2 = Color(0xFF373e52);
  static const Color blue_1 = Color(0xff015671);

  static const Color lightGrey  = Color(0xfff3f5f8);
  static const Color grey_1 = Color(0xFFDee0e5);
  static const Color grey_2 = Color(0xFFAFB6C8);
  static const Color grey_3 = Color(0xFF6b6f7a);
  static const Color grey_4 = Color(0xFFc5d3e9);
  static const Color grey_5 = Color(0xFF7c8192);
  static const Color grey_6 = Color(0xFF575f71);

  static const Color white = Color(0xFFFFFFFF);
  static const Color white_1 = Color(0xFFeef0f4);

  static const Color black_1 = Color(0xFF212634);
  static const Color black_2 = Color(0xFF202533);
  static const Color blackText_1 = Color(0xFF293246);
  static const Color black_4 = Color(0xFF222734);

  static const Color purple_1 = Color(0xff0088c2);
  static const Color purple_2 = Color(0xff2152ff);
  static const Color pink_1 = Color(0xffff109f);

  static const Color lightYellow = Color(0xFFFFF7ec);
  static const Color yellow = Color(0xffffa724);
static const Color darkGreen = Color(0xff418502);
static const Color darkGreen_2 = Color(0xff3a4331);

static const Color lightGreen_2 = Color(0xffc7ff94);
  static const Color green_3 = Color(0xff30c58f);
  static const Color green_1 = Color(0xff278764);
  static const Color green_2 = Color(0xff30c48f);
static const Color green = Color(0xff90FF2A);

  static const Color lightGreen = Color(0xffe7ffd0);
  static const Color lightRed = Color(0xFFffe8e8);
  static const Color red_2 = Color(0xffdc6c6c);
  static const Color red_1 = Color(0xFFFF7676);
  static const Color scaffoldBackgroundGrey = Color(0xFFdee0e5);
  static const Color scaffoldBackgroundDarkBlue = Color(0xff232938);

  static const Color backgroundLight = Color(0xFFFEEADD);
  // static Color dividerColor = Colors.grey[350];
  static const Color cardColorLight = Colors.white;
  static const Color disabledColor = Color(0xFF959DB6);
  static const Color iconTint = Color(0xFF776C6C);
  static const Color hintColorLight = Color(0xFF959DB6);

  // MISC
  static const Color primaryColor = Color(0xFFD91E23);
  static const Color secondaryColor = Color(0xFFD91E23);
  static const Color blueishGray = Color(0xFFD9E1FD);
  static const Color blueishBg = Color(0xFFF7F9FD);

  static const Color colorPrimaryDark = Color(0xFFCB5620);
  static const Color skyBlue = Color(0xFFEBF1FF);
  static const Color cyan = Color(0xFFD2F3FF);
  static const Color yellowish = Color(0xFFFFF1BF);
  static const Color lightBlack = Color(0xFF868686);
  static const Color notificationDotColor = Colors.blue;
  static const Color black = Colors.black;
}

double _baseFontSize = 16;
double _baseFontSizeSmaller = 14;
double _baseFontSizeLarger = 18;

final _textThemeLight = TextStyle(
  color: ColorPalette.black,
  fontSize: _baseFontSize,
  // fontFamily: _fontFamily,
);

var appThemeLight = ThemeData(
  primarySwatch: Colors.red,
  indicatorColor: ColorPalette.primaryColor,
  primaryColor: ColorPalette.primaryColor,
  backgroundColor: ColorPalette.backgroundLight,
  hintColor: ColorPalette.hintColorLight,
  brightness: Brightness.light,
  scaffoldBackgroundColor: ColorPalette.grey_1,
  // dividerColor: Pallet.dividerColor,
  disabledColor: ColorPalette.disabledColor,
  errorColor: Colors.red.shade800,
  cardColor: ColorPalette.cardColorLight,
  appBarTheme: AppBarTheme(
    color: ColorPalette.backgroundLight,
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: ColorPalette.black),
    textTheme: TextTheme(
      headline6: _textThemeLight.copyWith(
        fontSize: _baseFontSizeLarger,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
  // fontFamily: _fontFamily,
  tabBarTheme: TabBarTheme(
    unselectedLabelColor: ColorPalette.iconTint,
    labelColor: ColorPalette.primaryColor,
    unselectedLabelStyle: _textThemeLight.copyWith(fontSize: _baseFontSize),
    indicator: BoxDecoration(
        border:
            Border(bottom: BorderSide(color: ColorPalette.primaryColor, width: 2))),
    labelStyle: _textThemeLight.copyWith(
      fontSize: _baseFontSize,
      fontWeight: FontWeight.bold,
    ),
  ),
  iconTheme: IconThemeData(color: ColorPalette.iconTint),
  primaryTextTheme: TextTheme(
    bodyText1: _textThemeLight,
    bodyText2: _textThemeLight.copyWith(fontSize: _baseFontSizeSmaller),
    headline1: _textThemeLight.copyWith(
        fontWeight: FontWeight.bold, fontSize: _baseFontSizeLarger),
    headline2: _textThemeLight.copyWith(
        fontWeight: FontWeight.bold, fontSize: _baseFontSize),
    caption: _textThemeLight,
    subtitle1: _textThemeLight.copyWith(
        fontSize: 32, fontWeight: FontWeight.bold, color: ColorPalette.black),
    subtitle2: _textThemeLight.copyWith(
        fontWeight: FontWeight.w400, color: ColorPalette.iconTint),
    button: _textThemeLight,
  ),
);
