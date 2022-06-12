import 'package:flutter/material.dart';
import 'package:pencarian_jurnal/app/app.locator.dart';
import 'package:pencarian_jurnal/theme/app_color.dart';
import 'package:stacked_services/stacked_services.dart';

void setupSnackbarUi() {
  final snackbarService = locator<SnackbarService>();

  snackbarService.registerSnackbarConfig(
    SnackbarConfig(
      snackPosition: SnackPosition.TOP,
      backgroundColor: secondaryColor,
      titleColor: Colors.white,
      messageColor: Colors.white,
    ),
  );
}
