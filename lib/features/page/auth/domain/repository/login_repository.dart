import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:project_machine_test/features/page/auth/domain/model/login_model.dart';
import 'package:project_machine_test/features/resources/url_resources.dart';

class LoginRepository {
  final dio = Dio();
  Future<LoginModel> loginRepository(String username, String password) async {
    log("url checking ${UrlResources.login} post data ${"$username ====== $password"}");
    try {
      final formData = FormData.fromMap({"username": username, "password": password});

      final response = await dio.post(
        UrlResources.login,
        data: formData,
        options: Options(
          headers: <String, String>{
            "Content-Type": "application/json",
          },
        ),
      );
      if (response.statusCode == 200) {
        log("login url ${UrlResources.login} response $response");
        final responseData = response.data;
        return LoginModel.fromJson(responseData);
      } else {
        log("Error response: ${response.toString()}");
        throw Exception("login Failed");
      }
    } on DioException catch (e) {
      log('Error during login: $e');
      final errorResponse = e.response?.data;
      log(errorResponse.toString());
      throw e.error.toString();
    }
  }
}
