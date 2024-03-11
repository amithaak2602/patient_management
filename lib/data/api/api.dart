import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:patient_management_app/data/shared/shared_prefernce.dart';

class Api {
  String baseUrl = "https://flutter-amr.noviindus.in/api/";

  Future<bool> postLogin(String userName, String password) async {
    try {
      FormData formData = FormData.fromMap({
        'username': userName,
        'password': password,
      });

      String url = "${baseUrl}Login";
      Response response = await Dio().post(
        url,
        data: formData,
      );
      print(response);
      if ((response.statusCode ?? 0) == 200) {
        Map<String, dynamic> responseDataMap = json.decode('$response');
        if (responseDataMap['status'] == true) {

          final pref = await Shared().loadPref();
          pref.setString('token', responseDataMap['token']);
        }
        return true;
      }
      return false;
    } on DioException catch (e, st) {

      print(e);
      return false;
    }
  }
  Future postRegister(data) async {
    try {
      String url = "${baseUrl}PatientUpdate";
      final pref = await Shared().loadPref();
      String token = pref.getString('token') ?? "";
      print(token);
      Response response = await Dio().post(
        Uri.encodeFull(url),
        data: data,
        options: Options(
          headers: {
            'authorization': "Bearer $token",
          },
        ),
      );
      print(response.data);
      if ((response.statusCode ?? 0) == 200) {
        Map<String, dynamic> responseDataMap = json.decode('$response');
        if (responseDataMap['status'] == true) {
          // final pref = await Shared().loadPref();
          // pref.setString('token', responseDataMap['token']);
        }
        return true;
      }
      return false;
    } on DioException catch (e, st) {
      return e.response!.data;
    }
  }

  Future get(String subUrl) async {
    String url = baseUrl+subUrl;
    final pref = await Shared().loadPref();
    String token = pref.getString('token') ?? "";

    try {
      Response response = await Dio().get(
        Uri.encodeFull(url),
        options: Options(
          headers: {
            'authorization': "Bearer $token",
          },
        ),
      );
      Map<String, dynamic> responseDataMap = json.decode('$response');
      return responseDataMap;
    } on DioException catch (e) {
      print(e.response?.data);
      return e.response?.data;
      // throw Error();
    }
    return null;
  }
}
