import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:project_machine_test/features/page/register/domain/model/register_add_model.dart';
import 'package:project_machine_test/features/resources/pref_resources.dart';
import 'package:project_machine_test/features/resources/url_resources.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatientUpdateRepository {
  final dio = Dio();
  Future<PatientAddModel> patientUpdateRepository(
    dynamic name,
    dynamic excecutive,
    dynamic payment,
    dynamic phone,
    dynamic address,
    dynamic totalamount,
    dynamic discountamount,
    dynamic advanceamount,
    dynamic balanceamount,
    dynamic datendtime,
    dynamic male,
    dynamic female,
    dynamic branch,
    dynamic treatments,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final tocken = prefs.getString(PrefResources.USER_TOCKEN);
      final formData = FormData.fromMap({
        "name": name,
        "excecutive": excecutive,
        "payment": payment,
        "phone": phone,
        "address": address,
        "total_amount": totalamount,
        "discount_amount": discountamount,
        "advance_amount": advanceamount,
        "balance_amount": balanceamount,
        "date_nd_time": datendtime,
        "id": "",
        "male": male,
        "female": female,
        "branch": branch,
        "treatments": treatments,
      });
      log(""" name: $name,
                      excecutive: "Exec 1",
                      payment: $payment,
                      phone: $phone,
                      address: $address,
                      totalamount: ${(totalamount)},
                      discountamount: ${(discountamount)},
                      advanceamount: ${(advanceamount)},
                      balanceamount: ${(balanceamount.toString())},
                      datendtime: $datendtime,
                      male: $male,
                      female: $female,
                      branch: ${(branch)}
                      treatments: ${(treatments.toString())}

""");

      final response = await dio.post(
        UrlResources.patientUpdate,
        data: formData,
        options: Options(
          headers: <String, String>{
            "Content-Type": "application/json",
            "Authorization": "Bearer $tocken",
          },
        ),
      );
      if (response.statusCode == 200) {
        log("patientUpdate url ${UrlResources.patientUpdate} response $response");
        final responseData = response.data;
        return PatientAddModel.fromJson(responseData);
      } else {
        log("Error response: ${response.toString()}");
        throw Exception("patientUpdate Failed");
      }
    } on DioException catch (e) {
      log('Error during patientUpdate: $e');
      final errorResponse = e.response?.data;
      log(errorResponse.toString());
      throw e.error.toString();
    }
  }
}
