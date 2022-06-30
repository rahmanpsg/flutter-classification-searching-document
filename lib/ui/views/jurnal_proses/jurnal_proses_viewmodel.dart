import 'package:pencarian_jurnal/app/app.locator.dart';
import 'package:pencarian_jurnal/app/app.logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class JurnalProsesViewModel extends BaseViewModel {
  final log = getLogger('JurnalProsesViewModel');
  final _navigationService = locator<NavigationService>();

  void back() {
    _navigationService.back(id: 0);
  }
}
