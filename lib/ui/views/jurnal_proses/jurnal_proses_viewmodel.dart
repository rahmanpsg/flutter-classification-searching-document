import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:pencarian_jurnal/app/app.locator.dart';
import 'package:pencarian_jurnal/app/app.logger.dart';
import 'package:pencarian_jurnal/app/app.router.dart';
import 'package:pencarian_jurnal/models/hasil_tf_idf_model.dart';
import 'package:pencarian_jurnal/models/hasil_training_model.dart';
import 'package:pencarian_jurnal/models/jurnal_model.dart';
import 'package:pencarian_jurnal/services/jurnal_service.dart';
import 'package:pencarian_jurnal/services/knn_service.dart';
import 'package:pencarian_jurnal/services/table_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class JurnalProsesViewModel extends BaseViewModel {
  final log = getLogger('JurnalProsesViewModel');

  final _navigationService = locator<NavigationService>();
  final _tableService = locator<TableService>();

  final _knnService = KnnService();
  final _jurnalService = locator<JurnalService>();

  final expandedTileController = ExpandedTileController();
  final expandedTileController2 = ExpandedTileController();

  late final List<List<HasilTfIdfModel>> hasils;
  late final List<String> jurnals;
  late final HasilTrainingModel hasilTraining;

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  int hasilPengujianTabIndex = 0;

  void init() async {
    log.i('init');

    setBusyForObject('calculateTFIDF', true);
    setBusyForObject('pengujianKNN', true);

    try {
      final responseTFIDF = await _knnService.calculateTFIDF();

      log.i(responseTFIDF);

      if (responseTFIDF.data?.isNotEmpty ?? false) {
        hasils = responseTFIDF.data!;
        jurnals = _jurnalService.jurnals
            .map((jurnal) => jurnal.fileData?.name ?? '')
            .toList();
      }
    } catch (e) {
      log.e(e);
    }

    setBusyForObject('calculateTFIDF', false);

    try {
      final responseTraining = await _knnService.training();
      log.i(responseTraining.data);

      hasilTraining = responseTraining.data!;
    } catch (e) {
      log.e(e);
    }

    setBusyForObject('pengujianKNN', false);
  }

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
    _tableService.updateData();
  }

  void toPDFView(JurnalModel jurnal) {
    _navigationService.navigateTo(Routes.pdfView,
        arguments: PdfViewArguments(jurnal: jurnal));
  }

  void back() {
    _navigationService.back(id: 0);
  }
}
