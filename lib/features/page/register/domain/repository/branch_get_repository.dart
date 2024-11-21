import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:project_machine_test/features/page/register/domain/model/branch_model.dart';
import 'package:project_machine_test/features/resources/pref_resources.dart';
import 'package:project_machine_test/features/resources/url_resources.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BranchListRepository {
  final dio = Dio();
  Future<BranchListModel> branchListRepository() async {
    final prefs = await SharedPreferences.getInstance();
    final tocken = prefs.getString(PrefResources.USER_TOCKEN);
    try {
      final response = await dio.get(
        UrlResources.branchList,
        options: Options(
          headers: <String, String>{
            "Content-Type": "application/json",
            "Authorization": "Bearer $tocken",
          },
        ),
      );
      if (response.statusCode == 200) {
        log("branchList url ${UrlResources.branchList} response $response");
        final responseData = response.data;
        return BranchListModel.fromJson(responseData);
      } else {
        log("Error response: ${response.toString()}");
        throw Exception("branchList Failed");
      }
    } on DioException catch (e) {
      log('Error during branchList: $e');
      final errorResponse = e.response?.data;
      log(errorResponse.toString());
      throw e.error.toString();
    }
  }
}
