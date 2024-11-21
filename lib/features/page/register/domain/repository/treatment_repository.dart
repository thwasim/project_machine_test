import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:project_machine_test/features/page/register/domain/model/treatment_list_model.dart';
import 'package:project_machine_test/features/resources/pref_resources.dart';
import 'package:project_machine_test/features/resources/url_resources.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TreatmentListRepository {
  final dio = Dio();
  Future<TreatmentListModel> treatmentListRepository() async {
    final prefs = await SharedPreferences.getInstance();
    final tocken = prefs.getString(PrefResources.USER_TOCKEN);
    try {
      final response = await dio.get(
        UrlResources.treatmentList,
        options: Options(
          headers: <String, String>{
            "Content-Type": "application/json",
            "Authorization": "Bearer $tocken",
          },
        ),
      );
      if (response.statusCode == 200) {
        log("treatmentList url ${UrlResources.treatmentList} response $response");
        final responseData = response.data;
        return TreatmentListModel.fromJson(responseData);
      } else {
        log("Error response: ${response.toString()}");
        throw Exception("treatmentList Failed");
      }
    } on DioException catch (e) {
      log('Error during treatmentList: $e');
      final errorResponse = e.response?.data;
      log(errorResponse.toString());
      throw e.error.toString();
    }
  }
}
