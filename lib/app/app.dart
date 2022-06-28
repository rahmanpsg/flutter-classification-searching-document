import 'package:pencarian_jurnal/api/firebase_storage_api.dart';
import 'package:pencarian_jurnal/api/firestore_api.dart';
import 'package:pencarian_jurnal/models/jurnal_model.dart';
import 'package:pencarian_jurnal/models/prodi_model.dart';
import 'package:pencarian_jurnal/services/jurnal_service.dart';
import 'package:pencarian_jurnal/services/prodi_service.dart';
import 'package:pencarian_jurnal/ui/views/dashboard/dashboard_view.dart';
import 'package:pencarian_jurnal/ui/views/jurnal/jurnal_view.dart';
import 'package:pencarian_jurnal/ui/views/jurnal_folder/jurnal_folder_view.dart';
import 'package:pencarian_jurnal/ui/views/klasifikasi/klasifikasi_view.dart';
import 'package:pencarian_jurnal/ui/views/pdf/pdf_view.dart';
import 'package:pencarian_jurnal/ui/views/pencarian/pencarian_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:pencarian_jurnal/ui/views/home/home_view.dart';

@StackedApp(
  routes: [
    CupertinoRoute(page: HomeView, initial: true, children: [
      CupertinoRoute(page: DashboardView, initial: true),
      CupertinoRoute(page: JurnalView),
      CupertinoRoute(page: JurnalFolderView),
      CupertinoRoute(page: KlasifikasiView),
      CupertinoRoute(page: PencarianView),
    ]),
    CupertinoRoute(page: PdfView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: SnackbarService),
    LazySingleton(classType: FirebaseStorageApi),
    LazySingleton(classType: JurnalService),
    LazySingleton(classType: ProdiService),
  ],
  logger: StackedLogger(),
)
class AppSetup {
  /** Serves no purpose besides having an annotation attached to it */
}
