import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pencarian_jurnal/services/jurnal_service.dart';
import 'package:pencarian_jurnal/services/prodi_service.dart';
import 'package:pencarian_jurnal/theme/app_theme.dart';
import 'package:pencarian_jurnal/ui/shared/setup_dialog_ui.dart';
import 'package:pencarian_jurnal/ui/shared/setup_snackbar_ui.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app/app.locator.dart';
import 'app/app.router.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setupLocator();
  setupDialogUi();
  setupSnackbarUi();

  await locator<JurnalService>().syncData();
  await locator<ProdiService>().syncData();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return MaterialApp(
        title: 'Klasifikasi dan Pencarian Jurnal',
        navigatorKey: StackedService.navigatorKey,
        onGenerateRoute: StackedRouter().onGenerateRoute,
        theme: appTheme,
        scrollBehavior: const MaterialScrollBehavior().copyWith(
          dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
            PointerDeviceKind.stylus,
            PointerDeviceKind.unknown
          },
        ),
      );
    });
  }
}
