import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pencarian_jurnal/app/app.logger.dart';
import 'package:pencarian_jurnal/models/response_api_model.dart';

class Api {
  static final Dio _dio = Dio(BaseOptions(
    // baseUrl: GetPlatform.isAndroid
    //   ? 'http://10.0.2.2:3000/api'
    //   : 'http://localhost:3000/api',
    baseUrl: 'http://127.0.0.1:8000/api/',
    // baseUrl: 'https://knn-server.herokuapp.com/api/',
    // connectTimeout: 10000, //10 seconds
    // receiveTimeout: 10000,
  ));

  final log = getLogger('Api');

  Future<ResponseApiModel> get(String endpoint) async {
    try {
      final response = await _dio.get(endpoint);

      return ResponseApiModel(error: false, data: response.data);
    } on DioError catch (e) {
      log.e(e);
      if (e.type == DioErrorType.response) {
        return ResponseApiModel(error: true);
      }

      return ResponseApiModel(
        error: true,
        message: 'Terjadi masalah yang tidak diketahui',
      );
    } catch (e) {
      log.e(e);
      return ResponseApiModel(
        error: true,
        message: 'Terjadi masalah yang tidak diketahui',
      );
    }
  }

  Future<ResponseApiModel> post(String endpoint, dynamic body) async {
    try {
      final response = await _dio.post(endpoint, data: body);

      return ResponseApiModel(error: false, data: response.data);
    } on DioError catch (e) {
      log.e(e);
      if (e.type == DioErrorType.response) {
        return ResponseApiModel(error: true);
      }

      return ResponseApiModel(
        error: true,
        message: 'Terjadi masalah yang tidak diketahui',
      );
    } catch (e) {
      log.e(e);
      return ResponseApiModel(
        error: true,
        message: 'Terjadi masalah yang tidak diketahui',
      );
    }
  }
}
