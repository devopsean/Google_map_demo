import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_map_flutter/data/utils/color_palette.dart';

showToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: ColorPalette.lightBlue,
      textColor: ColorPalette.black,
      fontSize: 16.0);
}
