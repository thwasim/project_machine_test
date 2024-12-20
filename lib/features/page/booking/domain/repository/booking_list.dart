import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:project_machine_test/features/page/booking/domain/model/booking_list_model.dart';
import 'package:project_machine_test/features/resources/pref_resources.dart';
import 'package:project_machine_test/features/resources/url_resources.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatientListRepository {
  final dio = Dio();
  Future<BookingList> patientListRepository() async {
    final prefs = await SharedPreferences.getInstance();
    final tocken = prefs.getString(PrefResources.USER_TOCKEN);
    try {
      final response = await dio.get(
        UrlResources.patientList,
        options: Options(
          headers: <String, String>{
            "Content-Type": "application/json",
            "Authorization": "Bearer $tocken",
          },
        ),
      );
      if (response.statusCode == 200) {
        log("PatientList url ${UrlResources.patientList} response $response");
        final responseData = response.data;
        return BookingList.fromJson(responseData);
      } else {
        log("Error response: ${response.toString()}");
        throw Exception("PatientList Failed");
      }
    } on DioException catch (e) {
      log('Error during PatientList: $e');
      final errorResponse = e.response?.data;
      log(errorResponse.toString());
      throw e.error.toString();
    }
  }
}
