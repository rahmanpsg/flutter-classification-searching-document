import 'package:pencarian_jurnal/services/jurnal_service.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:pencarian_jurnal/ui/views/home/home_view.dart';

@StackedApp(
  routes: [
    CupertinoRoute(page: HomeView, initial: true),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: SnackbarService),
    LazySingleton(classType: JurnalService),
  ],
  logger: StackedLogger(),
)
class AppSetup {
  /** Serves no purpose besides having an annotation attached to it */
}
