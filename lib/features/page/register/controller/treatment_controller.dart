import 'package:flutter/material.dart';
import 'package:project_machine_test/features/page/register/domain/model/treatment_list_model.dart';
import 'package:project_machine_test/features/page/register/domain/repository/treatment_repository.dart';

class TreatmentState with ChangeNotifier {
  List<Map<String, String>> treatments = [];
  String? selectedTreatment;
  String? selectedTreatmentId;

  bool isLoading = false;
  String? error;

  int maleCount = 0;
  int femaleCount = 0;

  TreatmentListModel? treatmentListModel;

  Future<void> fetchTreatments() async {
    if (isLoading) return;

    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final response = await TreatmentListRepository().treatmentListRepository();
      treatmentListModel = response;

      treatments = treatmentListModel?.treatments
              ?.map((treatment) {
                return {
                  'id': (treatment.id ?? '0').toString(),
                  'name': (treatment.name ?? 'Unknown Treatment').toString(),
                };
              })
              .toList()
              .cast<Map<String, String>>() ??
          [];
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void setSelectedTreatment(String selectedName) {
    selectedTreatment = selectedName;

    selectedTreatmentId = treatments.firstWhere(
      (treatment) => treatment['name'] == selectedName,
      orElse: () => {'id': ""},
    )['id'];

    notifyListeners();
  }

  void incrementMale() {
    maleCount++;
    notifyListeners();
  }

  void decrementMale() {
    if (maleCount > 0) maleCount--;
    notifyListeners();
  }

  void incrementFemale() {
    femaleCount++;
    notifyListeners();
  }

  void decrementFemale() {
    if (femaleCount > 0) femaleCount--;
    notifyListeners();
  }
}
