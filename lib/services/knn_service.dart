import 'dart:convert';

import 'package:pencarian_jurnal/api/api.dart';
import 'package:pencarian_jurnal/app/app.logger.dart';
import 'package:pencarian_jurnal/models/jurnal_model.dart';
import 'package:pencarian_jurnal/models/response_api_model.dart';

class KnnService {
  final log = getLogger('KnnService');

  final api = Api();

  Future<ResponseApiModel<List<JurnalModel>>> prosesDokumen(
      String text, int K) async {
    try {
      final response = await api.postData('proses', {'text': text, 'k': K});

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
}
