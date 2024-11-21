import 'package:flutter/material.dart';
import 'package:project_machine_test/features/page/booking/domain/model/booking_list_model.dart';
import 'package:project_machine_test/features/page/booking/domain/repository/booking_list.dart';

class PatientListState with ChangeNotifier {
  bool isLoading = false;
  String? error;
  BookingList? bookingList;

  Future<void> patientList() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final response = await PatientListRepository().patientListRepository();
      bookingList = response;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

}
