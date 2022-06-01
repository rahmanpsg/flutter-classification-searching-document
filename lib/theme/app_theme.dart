import 'package:flutter/material.dart';

import 'app_color.dart';

ThemeData appTheme = ThemeData(
  primaryColor: primaryColor,
  canvasColor: greyThirdColor,
  fontFamily: 'Lato',
  textTheme: const TextTheme(
    headline1: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.w700,
      color: fontColor,
    ),
    headline2: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: fontColor,
    ),
    headline3: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: fontColor,
    ),
    subtitle1: TextStyle(
      fontSize: 16,
      color: fontGreyColor,
    ),
    subtitle2: TextStyle(
      fontSize: 14,
      color: fontGreyColor,
    ),
    bodyText1: TextStyle(fontSize: 16, color: fontGreyColor),
    bodyText2: TextStyle(fontSize: 14, color: fontGreyColor),
  ),
);
