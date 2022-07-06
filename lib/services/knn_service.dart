import 'dart:convert';

import 'package:pencarian_jurnal/api/api.dart';
import 'package:pencarian_jurnal/app/app.logger.dart';
import 'package:pencarian_jurnal/models/hasil_tf_idf_model.dart';
import 'package:pencarian_jurnal/models/hasil_training_model.dart';
import 'package:pencarian_jurnal/models/jurnal_model.dart';
import 'package:pencarian_jurnal/models/response_api_model.dart';

class KnnService {
  final log = getLogger('KnnService');

  final api = Api();

  Future<ResponseApiModel<List<JurnalModel>>> prosesDokumen(
      String text, int K) async {
    try {
      final response = await api.post('proses', {'text': text, 'k': K});

      List<JurnalModel> jurnals = [];

      for (var jurnal in jsonDecode(response.data)) {
        jurnals.add(JurnalModel.fromJson(jurnal));
      }

      return ResponseApiModel(error: false, data: jurnals);
    } catch (e) {
      log.e(e);
      // return ResponseApiModel(error: true, message: e.toString());
      rethrow;
    }
  }

  Future<ResponseApiModel<List<List<HasilTfIdfModel>>>> calculateTFIDF() async {
    try {
      final response = await api.get('calculateTFIDF');

      List<List<HasilTfIdfModel>> hasils = [];

      for (var docs in response.data) {
        List<HasilTfIdfModel> hasil = [];

        for (var doc in docs) {
          hasil.add(HasilTfIdfModel.fromJson(doc));
        }

        hasils.add(hasil);
      }

      return ResponseApiModel(error: false, data: hasils);
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }

  Future<ResponseApiModel<HasilTrainingModel>> training() async {
    try {
      final response = await api.get('training');

      return ResponseApiModel(
          error: false, data: HasilTrainingModel.fromJson(response.data));
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }
}
