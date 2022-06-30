import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pencarian_jurnal/api/firebase_storage_api.dart';
import 'package:pencarian_jurnal/api/firestore_api.dart';
import 'package:pencarian_jurnal/app/app.locator.dart';
import 'package:pencarian_jurnal/app/app.logger.dart';
import 'package:pencarian_jurnal/models/jurnal_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'prodi_service.dart';

class JurnalService with ReactiveServiceMixin {
  final log = getLogger('JurnalService');

  final _snackbarService = locator<SnackbarService>();
  final _prodiService = locator<ProdiService>();

  final _firestoreApi = FirestoreApi<JurnalModel>()
    ..collectionReference = FirebaseFirestore.instance
        .collection('jurnals')
        .withConverter<JurnalModel>(
          fromFirestore: (snapshot, _) =>
              JurnalModel.fromJson(snapshot.data()!),
          toFirestore: (movie, _) => movie.toJson(),
        );

  final ReactiveList<JurnalModel> _jurnals = ReactiveList<JurnalModel>();
  // final ReactiveValue<List<JurnalModel>> _jurnals =
  //     ReactiveValue<List<JurnalModel>>([]);

  List<JurnalModel> get jurnals => _jurnals;

  JurnalService() {
    listenToReactiveValues([_jurnals]);
  }

  Future<void> syncData() async {
    // final stream = _firestoreApi.getCollectionStream();

    // stream.listen((event) {
    //   // _jurnals.clear();
    //   // _jurnals.addAll(event.map((e) => e.data()));
    //   _jurnals.value = event.map((e) => e.data()).toList();

    //   log.i("update : ${_jurnals.value}");
    // });

    try {
      final response = await _firestoreApi.getDocuments();

      if (response.error) {
        log.e("error: ${response.message}");
        _snackbarService.showSnackbar(
          title: 'Error',
          message: response.message,
        );
        return;
      }

      if (response.data == null) return;

      for (var data in response.data!) {
        final jurnal = data.data();

        // find empty text in jurnal
        if (jurnal.fileData?.text == null || jurnal.fileData!.text!.isEmpty) {
          log.i(jurnal);
          log.i("empty text");
          // continue;
        }

        _jurnals.add(jurnal);

        // hitung jumlah jurnal per prodi
        if (jurnal.prodi != null) {
          final prodi = _prodiService.prodis
              .firstWhere((element) => element.nama == jurnal.prodi);

          prodi.jumlahJurnal++;

          prodi.bytes += jurnal.fileData!.bytes;
        }
      }

      // _jurnals.addAll(response.data!.map((e) => e.data()));
    } catch (e) {
      log.e(e);
    }
  }

  Future<void> addJurnal(JurnalModel jurnal) async {
    final response = await _firestoreApi.addDocument(jurnal);

    _snackbarService.showSnackbar(
      title: response.error ? 'Error' : 'Informasi',
      message: response.error ? response.message : 'Jurnal berhasil ditambakan',
    );

    if (response.error) {
      log.e("error: ${response.message}");

      return;
    }

    _jurnals.insert(0, jurnal);

    final prodi = _prodiService.prodis
        .firstWhere((element) => element.nama == jurnal.prodi);

    prodi.jumlahJurnal++;

    prodi.bytes += jurnal.fileData!.bytes;

    log.d("add jurnal : $jurnal");
  }

  Future<void> updateJurnal(JurnalModel newJurnal) async {
    final response =
        await _firestoreApi.updateDocument(newJurnal.id, newJurnal.toJson());

    _snackbarService.showSnackbar(
      title: response.error ? 'Error' : 'Informasi',
      message:
          response.error ? response.message : 'Data jurnal berhasil diubah',
    );

    if (response.error) {
      log.e("error: ${response.message}");
      return;
    }

    int index = _jurnals.indexWhere((j) => j.id == newJurnal.id);

    _jurnals.removeAt(index);
    _jurnals.insert(index, newJurnal);

    log.d("update jurnal : $newJurnal");
  }

  Future<void> deleteJurnal(JurnalModel jurnal) async {
    final response = await _firestoreApi.deleteDocument(jurnal.id);

    await locator<FirebaseStorageApi>()
        .deleteFile('jurnals/${jurnal.fileData?.name}');

    _snackbarService.showSnackbar(
      title: response.error ? 'Error' : 'Informasi',
      message: response.error ? response.message : 'Jurnal berhasil dihapus',
    );

    if (response.error) {
      log.e("error: ${response.message}");
      return;
    }

    _jurnals.remove(jurnal);

    final prodi = _prodiService.prodis
        .firstWhere((element) => element.nama == jurnal.prodi);

    prodi.jumlahJurnal--;

    prodi.bytes -= jurnal.fileData!.bytes;

    log.d("delete jurnal : $jurnal");
  }
}
