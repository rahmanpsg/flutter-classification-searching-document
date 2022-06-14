import 'package:dio/dio.dart';
import 'package:pencarian_jurnal/models/response_api_model.dart';

class Api {
  static final Dio _dio = Dio(BaseOptions(
    // baseUrl: GetPlatform.isAndroid
    //   ? 'http://10.0.2.2:3000/api'
    //   : 'http://localhost:3000/api',
    baseUrl: 'http://127.0.0.1:8000/api/',
    // connectTimeout: 10000, //10 seconds
    receiveTimeout: 10000,
  ));

  Future<ResponseApiModel> postData(String endpoint, dynamic body,
      {Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.post(endpoint, data: body);

      print(response.data['jarak']);

      // return ResponseApiModel.fromJson(response.data);
      return ResponseApiModel(error: false, data: response.data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        return ResponseApiModel(error: true);
      }

      return ResponseApiModel(
        error: true,
        message: 'Terjadi masalah yang tidak diketahui',
      );
    } catch (e) {
      print(e);
      return ResponseApiModel(
        error: true,
        message: 'Terjadi masalah yang tidak diketahui',
      );
    }
  }
}
