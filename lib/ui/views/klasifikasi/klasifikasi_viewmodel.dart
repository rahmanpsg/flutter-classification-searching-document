import 'package:flutter/material.dart';
import 'package:pencarian_jurnal/app/app.logger.dart';
import 'package:pencarian_jurnal/models/file_data_model.dart';
import 'package:pencarian_jurnal/services/knn_service.dart';
import 'package:stacked/stacked.dart';

class KlasifikasiViewModel extends BaseViewModel {
  final log = getLogger('KlasifikasiViewModel');

  final KnnService _knnService = KnnService();

  FileDataModel? _fileData;
  final kController = TextEditingController();

  String? errorFileMessage;
  String? errorKMessage;

  void setFileData(FileDataModel fileData) {
    _fileData = fileData;
    notifyListeners();
  }

  void onSubmit() async {
    try {
      validate();

      setBusy(true);

      await _knnService.prosesDokumen(
          _fileData!.text!, int.parse(kController.text));

      setBusy(false);
    } on String catch (e) {
      log.e(e);
    }

    notifyListeners();
  }

  void validate() {
    if (_fileData == null) {
      throw errorFileMessage = 'Pilih file terlebih dahulu';
    }
    if (kController.text == '') {
      throw errorKMessage = 'Masukkan nilai K [3, 5, 7, 9]';
    }
  }
}
