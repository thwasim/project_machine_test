import 'package:flutter/material.dart';
import 'package:project_machine_test/features/page/register/domain/model/register_add_model.dart';
import 'package:project_machine_test/features/page/register/domain/repository/register_add_repository.dart';

class RegisterState with ChangeNotifier {
  String paymentOption = 'Cash';
  String? selectedHour = "00";
  String? selectedMinute = "00";
  String timePeriod = 'AM';

  void setPaymentOption(String option) {
    paymentOption = option;
    notifyListeners();
  }

  void setSelectedHour(String hour) {
    selectedHour = hour;
    notifyListeners();
  }

  void setTimePeriod(String period) {
    timePeriod = period;
    notifyListeners();
  }

  void setSelectedMinute(String minute) {
    selectedMinute = minute;
    notifyListeners();
  }

  bool isLoading = false;
  String? error;
  PatientAddModel? patientAddModel;

  Future<void> patientUpdate({
    required name,
    required excecutive,
    required payment,
    required phone,
    required address,
    required totalamount,
    required discountamount,
    required advanceamount,
    required balanceamount,
    required datendtime,
    required male,
    required female,
    required branch,
    required treatments,
  }) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final response = await PatientUpdateRepository()
          .patientUpdateRepository(name, excecutive, payment, phone, address, totalamount, discountamount, advanceamount, balanceamount, datendtime, male, female, branch, treatments);
      patientAddModel = response;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
