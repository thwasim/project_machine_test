import 'package:flutter/material.dart';
import 'package:project_machine_test/features/page/auth/domain/model/login_model.dart';
import 'package:project_machine_test/features/page/auth/domain/repository/login_repository.dart';
import 'package:project_machine_test/features/resources/pref_resources.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginState with ChangeNotifier {
  bool isLoading = false;
  String? error;
  LoginModel? user;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final response = await LoginRepository().loginRepository(usernameController.text.trim(), passwordController.text.trim());
      await saveDatasFromSharedPrefernces(response);
      user = response;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveDatasFromSharedPrefernces(LoginModel response) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(PrefResources.USER_TOCKEN, response.token.toString());
  }
}
