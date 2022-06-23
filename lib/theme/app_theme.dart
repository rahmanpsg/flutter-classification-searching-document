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
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0,
      primary: primaryColor,
      onPrimary: Colors.white,
      onSurface: greyColor,
      minimumSize: const Size(0, 45),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      side: const BorderSide(
        color: primaryColor,
        width: 1,
      ),
      primary: primaryColor,
      onSurface: primaryColor,
      minimumSize: const Size(0, 45),
    ),
  ),
  appBarTheme: const AppBarTheme(backgroundColor: primaryColor),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: primaryColor,
    contentTextStyle: TextStyle(
      color: Colors.white,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: primaryColor,
    unselectedItemColor: secondaryColor,
  ),
);
