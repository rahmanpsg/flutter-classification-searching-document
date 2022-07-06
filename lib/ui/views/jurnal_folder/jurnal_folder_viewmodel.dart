import 'package:pencarian_jurnal/app/app.locator.dart';
import 'package:pencarian_jurnal/app/app.logger.dart';
import 'package:pencarian_jurnal/models/prodi_model.dart';
import 'package:pencarian_jurnal/services/prodi_service.dart';
import 'package:pencarian_jurnal/ui/views/jurnal/jurnal_view.dart';
import 'package:pencarian_jurnal/ui/views/jurnal_proses/jurnal_proses_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class JurnalFolderViewModel extends BaseViewModel {
  final log = getLogger('JurnalFolderViewModel');

  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final _prodiService = locator<ProdiService>();

  List<ProdiModel> get prodis => _prodiService.prodis;

  void toJurnalView(ProdiModel prodi) {
    locator<ProdiService>().prodiSelected = prodi;
    _navigationService.navigateWithTransition(
      const JurnalView(),
      transitionStyle: Transition.fade,
      id: 0,
    );
  }

  void toJurnalProsesView() async {
    final response = await _dialogService.showConfirmationDialog(
        title: 'Proses Jurnal',
        description: 'Anda akan memulai proses jurnal?',
        dialogPlatform: DialogPlatform.Material);

    if (response?.confirmed != true) return;

    _navigationService.navigateWithTransition(
      const JurnalProsesView(),
      transitionStyle: Transition.rightToLeft,
      id: 0,
    );
  }
}
