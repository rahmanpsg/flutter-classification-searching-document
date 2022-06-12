import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pencarian_jurnal/api/firestore_api.dart';
import 'package:pencarian_jurnal/app/app.logger.dart';
import 'package:pencarian_jurnal/models/prodi_model.dart';

class ProdiService {
  final log = getLogger('ProdiService');

  final _firestoreApi = FirestoreApi<ProdiModel>()
    ..collectionReference = FirebaseFirestore.instance
        .collection('prodies')
        .withConverter<ProdiModel>(
          fromFirestore: (snapshot, _) => ProdiModel.fromJson(snapshot.data()!),
          toFirestore: (movie, _) => movie.toJson(),
        );

  final List<ProdiModel> _prodis = [];

  List<ProdiModel> get prodis => _prodis;

  Future<void> syncData() async {
    try {
      final response = await _firestoreApi.getDocuments();

      log.d("response : ${response.data}");

      if (response.error) {
        log.e("error: ${response.message}");
        return;
      }

      if (response.data == null) return;

      _prodis.addAll(response.data!.map((e) => e.data()));
    } catch (e) {
      log.e(e);
    }
  }
}
