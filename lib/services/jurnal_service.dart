import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pencarian_jurnal/api/firestore_api.dart';
import 'package:pencarian_jurnal/app/app.logger.dart';
import 'package:pencarian_jurnal/models/jurnal_model.dart';

class JurnalService {
  final log = getLogger('JurnalService');

  final _firestoreApi = FirestoreApi<JurnalModel>()
    ..collectionReference = FirebaseFirestore.instance
        .collection('jurnals')
        .withConverter<JurnalModel>(
          fromFirestore: (snapshot, _) =>
              JurnalModel.fromJson(snapshot.data()!),
          toFirestore: (movie, _) => movie.toJson(),
        );

  final List<JurnalModel> _jurnals = [];

  List<JurnalModel> get jurnals => _jurnals;

  Future<void> syncData() async {
    try {
      final response = await _firestoreApi.getDocuments<JurnalModel>();

      log.d("response : ${response.data}");

      if (response.error) {
        log.e("error: ${response.message}");
        return;
      }

      if (response.data == null) return;

      _jurnals.clear();

      _jurnals.addAll(response.data!.map((e) => e.data()));
    } catch (e) {
      log.e(e);
    }
  }

  Future<void> addJurnal(JurnalModel jurnal) async {
    final response = await _firestoreApi.addDocument(jurnal);

    log.d("response : ${response.data}");

    if (response.error) {
      log.e("error: ${response.message}");
      return;
    }

    _jurnals.add(jurnal);
  }
}
