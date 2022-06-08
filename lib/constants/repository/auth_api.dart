import 'dart:io';

import 'package:dio/dio.dart';
import 'package:final_project_ujian_soal/constants/api_url.dart';

class AuthAPI {
  Dio dioApi() {
    BaseOptions options = BaseOptions(
        baseUrl: ApiUrl.baseUrl,
        headers: {
          "x-api-key": ApiUrl.apiKey,
          HttpHeaders.contentTypeHeader: "application/json"
        },
        responseType: ResponseType.json);

    final dio = Dio(options);
    return dio;
  }

  Future<Map<String, dynamic>?> _getRequest({endpoint, param}) async {
    try {
      final dio = dioApi();
      final result = await dio.get(endpoint, queryParameters: param);
      return result.data;
    } on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout) {
        print("error time out");
      }
      print("error dio");
      print(e);
    } catch (e) {
      print("error lainnya");
    }
  }

  Future<Map<String, dynamic>?> _postRequest({endpoint, body}) async {
    try {
      final dio = dioApi();
      final result = await dio.post(endpoint, data: body);
      return result.data;
    } on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout) {
        print("error time out");
      }
      print("error dio");
    } catch (e) {
      print("error lainnya");
    }
  }

  Future<Map<String, dynamic>?> getUserByEmail(email) async {
    final result =
        await _getRequest(endpoint: ApiUrl.users, param: {"email": email});
    print("hasil get user");
    print(result);
    return result;
  }
}
