import 'package:flutter/material.dart';
import 'package:pencarian_jurnal/app/app.locator.dart';
import 'package:pencarian_jurnal/app/app.logger.dart';
import 'package:pencarian_jurnal/enums/dialog_type.dart';
import 'package:pencarian_jurnal/enums/form_dialog_type.dart';
import 'package:pencarian_jurnal/models/file_data_model.dart';
import 'package:pencarian_jurnal/models/jurnal_model.dart';
import 'package:pencarian_jurnal/services/jurnal_service.dart';
import 'package:pencarian_jurnal/services/prodi_service.dart';
import 'package:pencarian_jurnal/services/table_service.dart';
import 'package:pencarian_jurnal/ui/shared/form_dialog/form_dialog_view.dart';
import 'package:pencarian_jurnal/utils/debounce.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class TableViewModel extends ReactiveViewModel {
  final log = getLogger('TableViewModel');

  final _dialogService = locator<DialogService>();
  final _tableService = locator<TableService>();
  final _jurnalService = locator<JurnalService>();
  final _prodiService = locator<ProdiService>();

  final headerScrollController = ScrollController();
  final bodyScrollController = ScrollController();
  final searchController = TextEditingController();

  final _debounce = Debounce(const Duration(milliseconds: 1000));

  JurnalModel? _jurnal;

  FileDataModel? _file;
  FileDataModel? get file => _file;

  void init() async {
    bodyScrollController.addListener(() {
      headerScrollController.animateTo(
        bodyScrollController.offset,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeIn,
      );
    });

    searchController.addListener(() {
      _debounce.call(() {
        setSearchTextFilter(searchController.text);
      });
    });
  }

  void setSearchTextFilter(String text) {
    if (text.isEmpty) return;

    setBusy(true);

    // _listFiltered = _list
    //     .where(
    //         (value) => value.label.toLowerCase().contains(text.toLowerCase()))
    //     .toList();

    setBusy(false);
  }

  void setFile(FileDataModel? file) async {
    _jurnal =
        JurnalModel(fileData: file, prodi: _prodiService.prodiSelected?.nama);

    final response = await _dialogService.showCustomDialog(
      variant: DialogType.form,
      title: "Tambah Jurnal",
      data: FormDialogData(type: FormDialogType.add, jurnal: _jurnal!),
    );
    log.d("response : ${response?.data}");

    if (!response!.confirmed) return;

    _jurnalService.addJurnal(_jurnal!);

    _file = file;
    notifyListeners();
  }

  @override
  void dispose() {
    headerScrollController.dispose();
    bodyScrollController.dispose();
    super.dispose();
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices =>
      [_tableService, _jurnalService];
}
