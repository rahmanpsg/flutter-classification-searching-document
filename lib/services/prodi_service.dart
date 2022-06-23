import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pencarian_jurnal/api/firestore_api.dart';
import 'package:pencarian_jurnal/app/app.logger.dart';
import 'package:pencarian_jurnal/models/prodi_model.dart';
import 'package:stacked/stacked.dart';

class ProdiService with ReactiveServiceMixin {
  final log = getLogger('ProdiService');

  final _firestoreApi = FirestoreApi<ProdiModel>()
    ..collectionReference = FirebaseFirestore.instance
        .collection('prodies')
        .withConverter<ProdiModel>(
          fromFirestore: (snapshot, _) => ProdiModel.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        );

  final ReactiveList<ProdiModel> _prodis = ReactiveList<ProdiModel>();
  // final ReactiveValue<List<ProdiModel>> _prodis =
  //     ReactiveValue<List<ProdiModel>>([]);

  ProdiService() {
    listenToReactiveValues([_prodis]);
  }

  Future<void> syncData() async {
    try {
      final response = await _firestoreApi.getDocuments();

      log.d("response : ${response.data}");

      if (response.error) {
        log.e("error: ${response.message}");
        return;
      }

      if (response.data == null) return;

      final prodis = response.data!.map((e) => e.data()).toList()
        ..sort(
          (a, b) => a.fakultas.compareTo(b.fakultas),
        );

      _prodis.addAll(prodis);
    } catch (e) {
      log.e(e);
    }
  }

  List<ProdiModel> get prodis => _prodis;
}
