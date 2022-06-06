import 'package:flutter/material.dart';
import 'package:pencarian_jurnal/app/app.locator.dart';
import 'package:pencarian_jurnal/app/app.logger.dart';
import 'package:pencarian_jurnal/enums/dialog_type.dart';
import 'package:pencarian_jurnal/models/file_data_model.dart';
import 'package:pencarian_jurnal/models/jurnal_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class TableViewModel extends BaseViewModel {
  final log = getLogger('TableViewModel');

  final DialogService _dialogService = locator<DialogService>();

  final ScrollController headerScrollController = ScrollController();
  final ScrollController bodyScrollController = ScrollController();

  FileDataModel? _file;
  FileDataModel? get file => _file;

  void setFile(FileDataModel? file) async {
    _file = file;
    notifyListeners();
  }

  void init() async {
    // await Future.delayed(Duration(milliseconds: 500));
    // await locator<DialogService>().showCustomDialog(
    //   variant: DialogType.form,
    //   title: "Form Dialog",
    //   data: JurnalModel(),
    // );

    bodyScrollController.addListener(() {
      headerScrollController.animateTo(
        bodyScrollController.offset,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeIn,
      );
    });
  }
}
