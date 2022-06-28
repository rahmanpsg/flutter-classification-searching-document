// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, unused_import, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../models/jurnal_model.dart';
import '../ui/views/dashboard/dashboard_view.dart';
import '../ui/views/home/home_view.dart';
import '../ui/views/jurnal/jurnal_view.dart';
import '../ui/views/jurnal_folder/jurnal_folder_view.dart';
import '../ui/views/klasifikasi/klasifikasi_view.dart';
import '../ui/views/pdf/pdf_view.dart';
import '../ui/views/pencarian/pencarian_view.dart';

class Routes {
  static const String homeView = '/';
  static const String pdfView = '/pdf-view';
  static const all = <String>{
    homeView,
    pdfView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(
      Routes.homeView,
      page: HomeView,
      generator: HomeViewRouter(),
    ),
    RouteDef(Routes.pdfView, page: PdfView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    HomeView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const HomeView(),
        settings: data,
      );
    },
    PdfView: (data) {
      var args = data.getArgs<PdfViewArguments>(nullOk: false);
      return CupertinoPageRoute<dynamic>(
        builder: (context) => PdfView(
          key: args.key,
          jurnal: args.jurnal,
        ),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// PdfView arguments holder class
class PdfViewArguments {
  final Key? key;
  final JurnalModel jurnal;
  PdfViewArguments({this.key, required this.jurnal});
}

class HomeViewRoutes {
  static const String dashboardView = '/';
  static const String jurnalView = '/jurnal-view';
  static const String jurnalFolderView = '/jurnal-folder-view';
  static const String klasifikasiView = '/klasifikasi-view';
  static const String pencarianView = '/pencarian-view';
  static const all = <String>{
    dashboardView,
    jurnalView,
    jurnalFolderView,
    klasifikasiView,
    pencarianView,
  };
}

class HomeViewRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(HomeViewRoutes.dashboardView, page: DashboardView),
    RouteDef(HomeViewRoutes.jurnalView, page: JurnalView),
    RouteDef(HomeViewRoutes.jurnalFolderView, page: JurnalFolderView),
    RouteDef(HomeViewRoutes.klasifikasiView, page: KlasifikasiView),
    RouteDef(HomeViewRoutes.pencarianView, page: PencarianView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    DashboardView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const DashboardView(),
        settings: data,
      );
    },
    JurnalView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const JurnalView(),
        settings: data,
      );
    },
    JurnalFolderView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const JurnalFolderView(),
        settings: data,
      );
    },
    KlasifikasiView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const KlasifikasiView(),
        settings: data,
      );
    },
    PencarianView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const PencarianView(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Extension for strongly typed navigation
/// *************************************************************************

extension NavigatorStateExtension on NavigationService {
  Future<dynamic> navigateToHomeView({
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo(
      Routes.homeView,
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToNestedDashboardView({
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo(
      HomeViewRoutes.dashboardView,
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToNestedJurnalView({
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo(
      HomeViewRoutes.jurnalView,
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToNestedJurnalFolderView({
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo(
      HomeViewRoutes.jurnalFolderView,
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToNestedKlasifikasiView({
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo(
      HomeViewRoutes.klasifikasiView,
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToNestedPencarianView({
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo(
      HomeViewRoutes.pencarianView,
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToPdfView({
    Key? key,
    required JurnalModel jurnal,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo(
      Routes.pdfView,
      arguments: PdfViewArguments(key: key, jurnal: jurnal),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }
}
