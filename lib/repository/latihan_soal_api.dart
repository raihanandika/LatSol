import 'dart:io';

import 'package:dio/dio.dart';
import 'package:final_project_ujian_soal/constants/api_url.dart';
import 'package:final_project_ujian_soal/helpers/user_email.dart';
import 'package:final_project_ujian_soal/models/network_response.dart';

class LatihanSoalAPI {
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

  Future<NetworkResponse> _getRequest({endpoint, param}) async {
    try {
      final dio = dioApi();
      final result = await dio.get(endpoint, queryParameters: param);
      return NetworkResponse.success(result.data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout) {
        return NetworkResponse.error(data: null, message: "request timeout");
      }
      return NetworkResponse.error(data: null, message: "request error dio");
    } catch (e) {
      return NetworkResponse.error(data: null, message: " other error");
    }
  }

  Future<NetworkResponse> _postRequest({endpoint, body}) async {
    try {
      final dio = dioApi();
      final result = await dio.post(endpoint, data: body);
      return NetworkResponse.success(result.data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout) {
        return NetworkResponse.error(data: null, message: "request timeout");
      }
      return NetworkResponse.error(data: null, message: "request error dio");
    } catch (e) {
      return NetworkResponse.error(data: null, message: " other error");
    }
  }

  Future<NetworkResponse> getMapel() async {
    final result = await _getRequest(
        endpoint: ApiUrl.latihanMapel,
        param: {"major_name": "IPA", "user_email": UserEmail.getUserEmail()});
    return result;
  }

  Future<NetworkResponse> getPaketSoal(id) async {
    final result = await _getRequest(
        endpoint: ApiUrl.latihanPaketSoal,
        param: {"course_id": id, "user_email": UserEmail.getUserEmail()});
    return result;
  }

  Future<NetworkResponse> getBanner() async {
    final result = await _getRequest(
      endpoint: ApiUrl.banner,
      // param: {"major_name": "IPA", "email": UserEmail.getUserEmail()}
    );
    return result;
  }

  Future<NetworkResponse> postQuestion(id) async {
    final result = await _postRequest(
        endpoint: ApiUrl.latihanKerjakanSoal,
        body: {"exercise_id": id, "user_email": UserEmail.getUserEmail()});
    return result;
  }
}
