import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pencarian_jurnal/api/firebase_storage_api.dart';
import 'package:pencarian_jurnal/app/app.locator.dart';
import 'package:pencarian_jurnal/app/app.logger.dart';
import 'package:pencarian_jurnal/enums/form_dialog_type.dart';
import 'package:pencarian_jurnal/models/jurnal_model.dart';
import 'package:pencarian_jurnal/models/prodi_model.dart';
import 'package:pencarian_jurnal/services/prodi_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'form_dialog_view.dart';

class FormDialogViewModel extends BaseViewModel {
  final log = getLogger('FormDialogViewModel');

  final _firebaseStorageApi = locator<FirebaseStorageApi>();

  late final Function(DialogResponse) completer;

  late final JurnalModel jurnal;
  late final FormDialogType type;

  String? errorMessage;

  final TextEditingController searchController = TextEditingController();

  final TextEditingController namaController = TextEditingController();
  final TextEditingController nimController = TextEditingController();
  final TextEditingController tahunController = TextEditingController();
  final TextEditingController prodiController = TextEditingController();

  List<ProdiModel> get prodis => locator<ProdiService>().prodis;

  void init(Function(DialogResponse) completer, FormDialogData data) {
    this.completer = completer;
    jurnal = data.jurnal;
    type = data.type;

    namaController.text = jurnal.nama ?? '';
    nimController.text = jurnal.nim ?? '';
    tahunController.text = jurnal.tahun ?? '';
    prodiController.text = jurnal.prodi ?? '';

    namaController.addListener(() {
      jurnal.nama = namaController.text;
    });
    nimController.addListener(() {
      jurnal.nim = nimController.text;
    });
    prodiController.addListener(() {
      jurnal.prodi = prodiController.text;
    });
  }

  void onSubmit() async {
    if (isBusy) return;

    setBusy(true);

    if (!jurnal.isValid) {
      errorMessage = "Semua data harus diisi";
      setBusy(false);

      return;
    }

    switch (type) {
      case FormDialogType.add:
        // Upload file
        UploadTask? uploadTask = await _firebaseStorageApi.uploadFile(
            'jurnals/${jurnal.fileData!.name}',
            jurnal.fileData!.data!,
            jurnal.fileData!.mime);

        if (uploadTask == null) return;

        log.d("Uploading file...");

        uploadTask.then((ts) async {
          log.d("Uploading file success");

          final url = await ts.ref.getDownloadURL();

          log.i(url);

          jurnal.fileData?.url = url;

          completer(
            DialogResponse(
              confirmed: true,
              data: jurnal,
            ),
          );

          setBusy(false);
        }).catchError((e) {
          log.e("error : $e");
          errorMessage = e.toString();
        });
        break;
      case FormDialogType.edit:
        completer(
          DialogResponse(
            confirmed: true,
            data: jurnal,
          ),
        );
        setBusy(false);
        break;
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    namaController.dispose();
    nimController.dispose();
    tahunController.dispose();
    prodiController.dispose();

    super.dispose();
  }
}
