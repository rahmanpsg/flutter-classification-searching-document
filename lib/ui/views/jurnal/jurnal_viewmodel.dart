import 'package:pencarian_jurnal/app/app.locator.dart';
import 'package:pencarian_jurnal/app/app.logger.dart';
import 'package:pencarian_jurnal/app/app.router.dart';
import 'package:pencarian_jurnal/enums/dialog_type.dart';
import 'package:pencarian_jurnal/enums/form_dialog_type.dart';
import 'package:pencarian_jurnal/models/jurnal_model.dart';
import 'package:pencarian_jurnal/services/jurnal_service.dart';
import 'package:pencarian_jurnal/ui/shared/form_dialog/form_dialog_view.dart';
import 'package:pencarian_jurnal/ui/views/table/models/column_item.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class JurnalViewModel extends ReactiveViewModel {
  final log = getLogger('JurnalViewModel');

  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final _jurnalService = locator<JurnalService>();

  List<JurnalModel> get jurnals => _jurnalService.jurnals;

  final List<ColumnItem> tableColumns = [
    ColumnItem(value: "No", width: 60),
    ColumnItem(value: "File", width: 350),
    ColumnItem(value: "Penulis", width: 300),
    ColumnItem(value: "Tahun", width: 100),
    ColumnItem(value: "Prodi", width: 150),
    // ColumnItem(value: "Status", width: 150),
    ColumnItem(value: "Aksi", width: 150),
  ];

  void toPDFView(JurnalModel jurnal) {
    _navigationService.navigateTo(Routes.pdfView,
        arguments: PdfViewArguments(jurnal: jurnal));
  }

  void onDownloadTap(JurnalModel jurnal) {
    log.d("onDownloadTap : ${jurnal.fileData?.name}");
  }

  void onEditTap(JurnalModel jurnal) async {
    log.d("onEditTap : ${jurnal.fileData?.name}");

    final response = await _dialogService.showCustomDialog(
      variant: DialogType.form,
      title: "Ubah Data Jurnal",
      data: FormDialogData(type: FormDialogType.edit, jurnal: jurnal),
    );
    log.d("response : ${response?.data}");

    if (!response!.confirmed) return;

    _jurnalService.updateJurnal(jurnal);
  }

  void onDeleteTap(JurnalModel jurnal) async {
    log.d("onDeleteTap : ${jurnal.fileData?.name}");

    final response = await _dialogService.showConfirmationDialog(
      title: 'Informasi',
      description:
          'Apakah anda yakin ingin menghapus jurnal ${jurnal.fileData?.name} ?',
      dialogPlatform: DialogPlatform.Custom,
    );

    if (!response!.confirmed) return;

    _jurnalService.deleteJurnal(jurnal);
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_jurnalService];
}
