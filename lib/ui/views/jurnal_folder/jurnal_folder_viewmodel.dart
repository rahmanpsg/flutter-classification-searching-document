import 'package:pencarian_jurnal/app/app.locator.dart';
import 'package:pencarian_jurnal/app/app.logger.dart';
import 'package:pencarian_jurnal/models/prodi_model.dart';
import 'package:pencarian_jurnal/services/prodi_service.dart';
import 'package:pencarian_jurnal/ui/views/jurnal/jurnal_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class JurnalFolderViewModel extends BaseViewModel {
  final log = getLogger('JurnalFolderViewModel');

  final _navigationService = locator<NavigationService>();
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
}
