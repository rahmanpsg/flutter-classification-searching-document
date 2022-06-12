import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pencarian_jurnal/app/app.logger.dart';
import 'package:pencarian_jurnal/models/response_api_model.dart';

class FirestoreApi<T> {
  final log = getLogger("FirestoreApi");

  final _firebaseFirestore = FirebaseFirestore.instance;

  /// need to set collection reference if you call this class
  late CollectionReference<T> collectionReference;

  Stream<List<QueryDocumentSnapshot<T>>> getCollectionStream() {
    return collectionReference.snapshots().map((event) => event.docs);
  }

  Future<ResponseApiModel<T>> getDocument(String documentId) async {
    log.d("path : ${collectionReference.path}");

    try {
      final response = await collectionReference.doc(documentId).get();

      log.d("response : ${response.data()}");

      return ResponseApiModel(error: false, data: response.data());
    } on FirebaseException catch (e) {
      log.e("error: ${e.toString()}");
      return ResponseApiModel(error: true, message: e.message ?? '');
    } catch (e) {
      log.e(e);
      return ResponseApiModel(error: true, message: e.toString());
    }
  }

  Future<ResponseApiModel<List<QueryDocumentSnapshot<T>>>>
      getDocuments() async {
    log.d("path : ${collectionReference.path}");

    log.d('T : $T');

    try {
      final response = await collectionReference.get();
      log.d("response length: ${response.docs.length}");

      return ResponseApiModel(
        error: false,
        data: response.docs,
      );
    } on FirebaseException catch (e) {
      log.e("error: ${e.toString()}");
      return ResponseApiModel(error: true, message: e.message ?? '');
    } catch (e) {
      log.e("error: ${e.toString()}");
      return ResponseApiModel(error: true, message: e.toString());
    }
  }

  Future<ResponseApiModel> addDocument(T data, [String? documentID]) async {
    log.i("path : ${collectionReference.path}, data :$data");

    try {
      await _firebaseFirestore.runTransaction((Transaction transactionHandler) {
        return collectionReference
            .doc(documentID ?? (data as dynamic).id)
            .set(data, SetOptions(merge: true));
      });

      log.i("addDocument: success");
      return ResponseApiModel(error: false);
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
      await _firebaseFirestore
          .runTransaction((Transaction transactionHandler) async {
        return collectionReference.doc(documentId).update(data);
      });

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
