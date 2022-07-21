import 'package:flutter/material.dart';
import 'package:pencarian_jurnal/app/app.locator.dart';
import 'package:pencarian_jurnal/app/app.logger.dart';
import 'package:pencarian_jurnal/app/app.router.dart';
import 'package:pencarian_jurnal/models/jurnal_model.dart';
import 'package:pencarian_jurnal/models/response_api_model.dart';
import 'package:pencarian_jurnal/services/knn_service.dart';
import 'package:pencarian_jurnal/utils/preprocessing.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PencarianViewModel extends BaseViewModel {
  final log = getLogger('PencarianViewModel');

  final _navigationService = locator<NavigationService>();

  final KnnService _knnService = KnnService();

  final kataController = TextEditingController();
  final kController = TextEditingController();

  String? errorKataMessage;
  String? errorKMessage;

  List<JurnalModel>? result;

  Duration? _duration;

  String get duration => _duration?.toString() ?? '0:00:00';

  void onSubmit() async {
    try {
      validate();

      setBusy(true);

      // log stopwatch
      final stopwatch = Stopwatch()..start();

      // final textClean = await Preprocessing().preprocess(kataController.text);

      final response = await _knnService.prosesDokumen(
          kataController.text, int.parse(kController.text));

      result = response.data;

      stopwatch.stop();
      log.i('proses dokumen: ${stopwatch.elapsed}');

      _duration = stopwatch.elapsed;
    } on String catch (e) {
      log.e(e);
    } on ResponseApiModel catch (e) {
      log.e(e);
    } catch (e) {
      log.e(e);
    }
    setBusy(false);

    notifyListeners();
  }

  void validate() {
    errorKataMessage = null;
    errorKMessage = null;

    if (kataController.text.isEmpty) {
      throw errorKataMessage = 'Kata kunci harus diisi';
    }
    if (kController.text == '' ||
        (kController.text != '3' &&
            kController.text != '5' &&
            kController.text != '7' &&
            kController.text != '9')) {
      throw errorKMessage = 'Masukkan nilai K [3, 5, 7, 9]';
    }
  }

  void toPDFView(JurnalModel jurnal) {
    log.i("fileData ${jurnal.fileData}");
    _navigationService.navigateTo(Routes.pdfView,
        arguments: PdfViewArguments(jurnal: jurnal));
  }
}
