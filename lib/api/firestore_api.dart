import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pencarian_jurnal/app/app.logger.dart';
import 'package:pencarian_jurnal/models/response_api_model.dart';

class FirestoreApi<T> {
  final log = getLogger("FirestoreApi");

  /// need to set collection reference if you call this class
  late CollectionReference<T> collectionReference;

  Future<ResponseApiModel<R>> getDocument<R>(String documentId) async {
    log.d("path : ${collectionReference.path}");

    try {
      final response = await collectionReference.doc(documentId).get();

      log.d("response : ${response.data()}");

      return ResponseApiModel(error: false, data: response.data() as R);
    } on FirebaseException catch (e) {
      log.e("error: ${e.toString()}");
      return ResponseApiModel(error: true, message: e.message ?? '');
    } catch (e) {
      log.e(e);
      return ResponseApiModel(error: true, message: e.toString());
    }
  }

  Future<ResponseApiModel<List<QueryDocumentSnapshot<R>>>>
      getDocuments<R>() async {
    log.d("path : ${collectionReference.path}");

    log.d('T : $T');

    try {
      final response = await collectionReference.get();
      log.d("response length: ${response.docs.length}");

      return ResponseApiModel(
        error: false,
        data: response.docs as List<QueryDocumentSnapshot<R>>,
      );
    } on FirebaseException catch (e) {
      log.e("error: ${e.toString()}");
      return ResponseApiModel(error: true, message: e.message ?? '');
    } catch (e) {
      log.e("error: ${e.toString()}");
      return ResponseApiModel(error: true, message: e.toString());
    }
  }

  Future<ResponseApiModel> addDocument(T data) async {
    log.i("path : ${collectionReference.path}, data :$data");

    try {
      final response = await collectionReference.add(data);

      log.i("addDocument: success");
      return ResponseApiModel(error: false, data: response);
    } on FirebaseException catch (e) {
      log.e("error: ${e.toString()}");
      return ResponseApiModel(error: true, message: e.message ?? '');
    } catch (e) {
      log.e(e);
      return ResponseApiModel(error: true, message: e.toString());
    }
  }

  Future<ResponseApiModel> updateDocument(
      String documentId, Map<String, dynamic> data) async {
    log.i(
        "path : ${collectionReference.path}, documenId : $documentId, data :$data");

    try {
      await collectionReference.doc(documentId).update(data);

      log.i("updateDocument: success");
      return ResponseApiModel(error: false);
    } on FirebaseException catch (e) {
      log.e("error: ${e.toString()}");
      return ResponseApiModel(error: true, message: e.message ?? '');
    } catch (e) {
      log.e(e);
      return ResponseApiModel(error: true, message: e.toString());
    }
  }

  Future<ResponseApiModel> deleteDocument(String documentId) async {
    log.i("path : ${collectionReference.path}, documenId : $documentId,");
    try {
      await collectionReference.doc(documentId).delete();

      log.i("deleteDocument: success");
      return ResponseApiModel(error: false);
    } on FirebaseException catch (e) {
      log.e("error: ${e.toString()}");
      return ResponseApiModel(error: true, message: e.message ?? '');
    } catch (e) {
      log.e(e);
      return ResponseApiModel(error: true, message: e.toString());
    }
  }
}
