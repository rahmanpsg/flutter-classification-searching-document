import 'package:pencarian_jurnal/api/api.dart';
import 'package:pencarian_jurnal/app/app.logger.dart';
import 'package:pencarian_jurnal/models/response_api_model.dart';

class KnnService {
  final log = getLogger('KnnService');

  final api = Api();

  Future<ResponseApiModel> prosesDokumen(String text, int K) async {
    try {
      final response = await api.postData('proses', {'text': text, 'k': K});

      log.d(response);

      return response;
    } catch (e) {
      log.e(e);
      return ResponseApiModel(error: true, message: e.toString());
    }
  }
}
