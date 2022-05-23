import 'package:flutter/material.dart';

class Helper {
  static double deviceWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double deviceHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getWidthWRTDevice(double width, BuildContext context) {
    return width / 375 * MediaQuery.of(context).size.width;
  }

  static double getHeightWRTDevice(double height, BuildContext context) {
    return height / 812 * MediaQuery.of(context).size.height;
  }
}
