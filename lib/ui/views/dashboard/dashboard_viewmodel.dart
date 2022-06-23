import 'package:pencarian_jurnal/app/app.locator.dart';
import 'package:pencarian_jurnal/services/jurnal_service.dart';
import 'package:pencarian_jurnal/services/prodi_service.dart';
import 'package:stacked/stacked.dart';

class DashboardViewModel extends ReactiveViewModel {
  final _jurnalService = locator<JurnalService>();
  final _prodiService = locator<ProdiService>();

  int get totalJurnal => _jurnalService.jurnals.length;
  int get totalProdi => _prodiService.prodis.length;

  @override
  List<ReactiveServiceMixin> get reactiveServices =>
      [_jurnalService, _prodiService];
}
