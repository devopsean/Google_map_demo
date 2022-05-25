import 'package:flutter/material.dart';
import 'package:google_map_flutter/data/utils/color_palette.dart';
import 'package:google_map_flutter/data/utils/dimensions.dart';

final poppinsBlack_1 = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w900,
  fontSize: Dimensions.fontSizeLarge,
);

final staatliches_1 = TextStyle(
  color: ColorPalette.black_2,
  fontFamily: 'Staatliches',
  fontWeight: FontWeight.w400,
  fontSize: Dimensions.fontSizeSuperLarge,
);
final staatliches_400_16_black = TextStyle(
  color: ColorPalette.black_2,
  fontFamily: 'Staatliches',
  fontWeight: FontWeight.w400,
  fontSize: 16,
);
final staatliches_400_48_white = TextStyle(
  color: ColorPalette.white,
  fontFamily: 'Staatliches',
  fontWeight: FontWeight.w400,
  fontSize: 48,
);
final staatliches_400_48_green = TextStyle(
  color: ColorPalette.green,
  fontFamily: 'Staatliches',
  fontWeight: FontWeight.w400,
  fontSize: 48,
);
final staatliches_400_50_black = TextStyle(
  color: ColorPalette.black,
  fontFamily: 'Staatliches',
  fontWeight: FontWeight.w400,
  fontSize: 50,
);
final staatliches_400_25_white = TextStyle(
  color: ColorPalette.white,
  fontFamily: 'Staatliches',
  fontWeight: FontWeight.w400,
  fontSize: 25,
);

final staatliches_2 = TextStyle(
  color: ColorPalette.black_2,
  fontFamily: 'Staatliches',
  fontWeight: FontWeight.w400,
  fontSize: Dimensions.fontSizeDefault,
);

final staatliches_1_gradient = TextStyle(
    fontFamily: 'Staatliches',
    fontWeight: FontWeight.w400,
    fontSize: Dimensions.fontSizeSuperLarge,
    foreground: Paint()..shader = linearGradient_2);

final staatliches_400_50_green_gradient = TextStyle(
    fontFamily: 'Staatliches',
    fontWeight: FontWeight.w400,
    fontSize: Dimensions.fontSizeSuperLarge,
    foreground: Paint()..shader = linearGradientGreen);

///Gradient Shaders

final Shader linearGradient_1 = LinearGradient(
  colors: <Color>[Color(0xff1b212f), Color(0xff6a6a70)],
).createShader(
  Rect.fromLTWH(
    0.0,
    0.0,
    0.0,
    0.0,
  ),
);

final Shader linearGradient_2 = LinearGradient(
  colors: <Color>[Color(0xff202533), Color(0xff79787b)],
).createShader(Rect.fromLTWH(0.0, 0.0, 0.0, 0.0));
final Shader linearGradientGreen = LinearGradient(
  colors: <Color>[Color(0xff90ff2a), Color(0xff58b006)],
).createShader(Rect.fromLTWH(0.0, 0.0, 0.0, 0.0));

final robotoGradient_1 = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w900,
    fontSize: Dimensions.fontSizeDefault,

    foreground: Paint()..shader = linearGradient_1);

final robotoGradient_2 = TextStyle(
    letterSpacing: 0.47 * 8,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w900,
    fontSize: Dimensions.fontSizeExtraLarge,
    foreground: Paint()..shader = linearGradient_1);

final robotoNormal_1 = TextStyle(
    color: ColorPalette.black_1,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
    fontSize: Dimensions.fontSizeDefault,
    letterSpacing: 12 * .135);

final robotoNormal_2 = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    fontSize: Dimensions.fontSizeSmall,
    color: ColorPalette.darkBlue_1,
    letterSpacing: 0.135 * 12);

final roboto_400_9_grey = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w400,
  fontSize: Dimensions.fontSizeExtraSmall,
  color: ColorPalette.grey_5,
);
const roboto_700_9_purple = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w700,
  fontSize: 12,
  color: ColorPalette.purple_2,
);
final roboto_400_12_green = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w400,
  fontSize: 12,
  color: ColorPalette.green_2,
);
final roboto_400_12_black = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w400,
  fontSize: 12,
  color: ColorPalette.black_1,
);
final roboto_400_12_white = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w400,
  fontSize: 12,
  color: ColorPalette.white,
);
final roboto_400_20_white = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w400,
  fontSize: 20,
  color: ColorPalette.white,
);
final roboto_400_14_grey = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w400,
  fontSize: 14,
  color: ColorPalette.grey_6,
);
final roboto_400_14_green = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w400,
  fontSize: 14,
  color: ColorPalette.darkGreen,
);

final roboto_400_10_black = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w400,
  fontSize: 10,
  color: ColorPalette.black_1,
);
final roboto_400_16_black = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w400,
  fontSize: 16,
  color: ColorPalette.black_1,
);

final roboto_400_16_white = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w400,
  fontSize: 16,
  color: ColorPalette.white,
);
final roboto_400_14_black = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w400,
  fontSize: 14,
  color: ColorPalette.black_1,
);
final roboto_400_11_black = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w400,
  fontSize: 11,
  color: ColorPalette.black_1,
);
final robotoCondensed_400_18_black = TextStyle(
  fontFamily: 'RobotoCondensed',
  fontWeight: FontWeight.w400,
  fontSize: 18,
  color: ColorPalette.black_1,
);

final roboto_500_11_red = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
    fontSize: Dimensions.fontSizeExtraSmall,
    color: ColorPalette.red_2);

final roboto_500_11_green = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
    fontSize: Dimensions.fontSizeExtraSmall,
    color: ColorPalette.green_1);
final roboto_500_14_red = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
    fontSize: Dimensions.fontSizeSmall,
    color: ColorPalette.red_2);

final roboto_500_14_green = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
    fontSize: Dimensions.fontSizeSmall,
    color: ColorPalette.green_1);
final roboto_500_14_black = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
    fontSize: Dimensions.fontSizeSmall,
    color: ColorPalette.blackText_1);
final roboto_500_16_green = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: ColorPalette.darkGreen);
final roboto_500_18_green = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
    fontSize: 18,
    color: ColorPalette.darkGreen);
final roboto_400_25_purple = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    fontSize: 25,
    color: ColorPalette.purple_2);
final roboto_400_35_black = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    fontSize: 35,
    color: ColorPalette.black);

final sfprodisplay_500_25_black = TextStyle(
    fontFamily: 'SfProDisplay',
    fontWeight: FontWeight.w500,
    fontSize: 25,
    color: ColorPalette.black);
final sfprodisplay_500_35_black = TextStyle(
    fontFamily: 'SfProDisplay',
    fontWeight: FontWeight.w500,
    fontSize: 35,
    color: ColorPalette.black);
final roboto_500_22_black = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
    fontSize: 22,
    color: ColorPalette.black_1);
final roboto_900_100_green = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w900,
    fontSize: 100,
    color: ColorPalette.green);
final roboto_500_16_black = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: ColorPalette.black_1);
final roboto_500_13_white = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
    fontSize: 13,
    color: ColorPalette.white);
final roboto_500_12_black = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
    fontSize: 12,
    color: ColorPalette.black_1);
final roboto_500_12_red = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
    fontSize: 12,
    color: ColorPalette.red_2);
final roboto_500_11_black = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
    fontSize: 11,
    color: ColorPalette.black_1);
final roboto_500_12_green = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
    fontSize: 12,
    color: ColorPalette.green_3);
final roboto_500_13_black = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
    fontSize: 13,
    color: ColorPalette.black_1);

final robotoNormal_3 = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
    fontSize: Dimensions.fontSizeSmall,
    color: ColorPalette.white);

final robotoNormal_4 = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    fontSize: Dimensions.fontSizeExtraSmall,
    color: ColorPalette.black_4);

final robotoNormal_5 = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    fontSize: Dimensions.fontSizeLarge,
    color: Colors.black);
final robotoHuge = TextStyle(
    color: ColorPalette.white,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w900,
    // letterSpacing: 1,
    fontSize: Dimensions.fontSizeOverLarge);
final roboto_900_218_green = TextStyle(
    color: ColorPalette.green,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w900,
    fontSize: 218);

final robotoRegular = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w400,
  fontSize: Dimensions.fontSizeDefault,
);

final robotoMedium = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w500,
  fontSize: Dimensions.fontSizeDefault,
);

final roboto700 = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w700,
  fontSize: Dimensions.fontSizeDefault,
);

final robotoBlack = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w900,
  fontSize: Dimensions.fontSizeDefault,
);

//RobotoSlab font definition for text body
const robotoSlabExtraLight = TextStyle(
  fontFamily: 'RobotoSlab',
  fontWeight: FontWeight.w100,
);

const robotoSlabThin = TextStyle(
  fontFamily: 'RobotoSlab',
  fontWeight: FontWeight.w200,
);

const robotoSlabRegular = TextStyle(
  fontFamily: 'RobotoSlab',
  fontWeight: FontWeight.w400,
);

const robotoSlabMedium = TextStyle(
  fontFamily: 'RobotoSlab',
  fontWeight: FontWeight.w500,
);

const robotoSlabBold = TextStyle(
  fontFamily: 'RobotoSlab',
  fontWeight: FontWeight.w700,
);

const robotoSlabBlack = TextStyle(
  fontFamily: 'RobotoSlab',
  fontWeight: FontWeight.w900,
);

//Raleway font definition for text body
const ralewayExtraLight = TextStyle(
  fontFamily: 'Raleway',
  fontWeight: FontWeight.w100,
);

const ralewayThin = TextStyle(
  fontFamily: 'Raleway',
  fontWeight: FontWeight.w200,
);

const ralewayRegular = TextStyle(
  fontFamily: 'Raleway',
  fontWeight: FontWeight.w400,
);

const ralewayMedium = TextStyle(
  fontFamily: 'Raleway',
  fontWeight: FontWeight.w500,
);

const ralewayBold = TextStyle(
  fontFamily: 'Raleway',
  fontWeight: FontWeight.w700,
);

const ralewayBlack = TextStyle(
  fontFamily: 'Raleway',
  fontWeight: FontWeight.w900,
);

///Box Decoration
const kButtonDecoration = BoxDecoration(color: Colors.green);

BoxDecoration? lightBlueContainerDecoration() {
  return BoxDecoration(
    color: ColorPalette.lightBlue,
    borderRadius: BorderRadius.all(Radius.circular(5)),
  );
}

BoxDecoration outlinedGreenContainerDecoration = BoxDecoration(
    color: ColorPalette.darkGreen,
    borderRadius: BorderRadius.all(Radius.circular(5)));

BoxDecoration? lightGreenContainerDecoration() {
  return BoxDecoration(
      color: ColorPalette.lightGreen,
      borderRadius: BorderRadius.all(Radius.circular(5)));
}

BoxDecoration? whiteContainerDecoration() {
  return BoxDecoration(
      color: ColorPalette.white,
      borderRadius: BorderRadius.all(Radius.circular(7)));
}

BoxDecoration? lightRedContainerDecoration() {
  return BoxDecoration(
      color: ColorPalette.lightRed,
      borderRadius: BorderRadius.all(Radius.circular(5)));
}

BoxDecoration? outlineBlackContainerDecoration() {
  return BoxDecoration(
      border: Border.all(), borderRadius: BorderRadius.all(Radius.circular(5)));
}

BoxDecoration? lightYellowContainerDecoration() {
  return BoxDecoration(
      color: ColorPalette.lightYellow,
      borderRadius: BorderRadius.all(Radius.circular(5)));
}

///Input Decoration
const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a your password',
  //contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.red),
  ),

  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Color(0xff535354), width: 1.0),
    // borderRadius: BorderRadius.all(Radius.circular(22.0)),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: ColorPalette.black_2, width: 2.0),
    // borderRadius: BorderRadius.all(Radius.circular(22.0)),
  ),
);

InputDecoration greenTextFieldDecoration = InputDecoration(
  hintText: 'Enter amount',
  hintStyle: roboto_400_14_green,
  //contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red),
    borderRadius: BorderRadius.all(Radius.circular(6.0)),
  ),

  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: ColorPalette.darkGreen, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(6.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: ColorPalette.darkGreen, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(6.0)),
  ),
);

///Animations
///
