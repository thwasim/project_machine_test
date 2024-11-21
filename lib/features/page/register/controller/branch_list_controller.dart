import 'package:flutter/material.dart';
import 'package:project_machine_test/features/page/register/domain/model/branch_model.dart';
import 'package:project_machine_test/features/page/register/domain/repository/branch_get_repository.dart';

class BranchListState with ChangeNotifier {
  bool isLoading = false;
  String? error;
  BranchListModel? branchListModel;

  String? selectedLocation;
  String? selectedBranch;

  String? selectedBranchId;
  String? selectedBranchName;

  void setSelectedBranch(String id, String name) {
    selectedBranchId = id;
    selectedBranchName = name;
    notifyListeners();
  }

  Future<void> branchList() async {
    if (isLoading) return;
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final response = await BranchListRepository().branchListRepository();
      branchListModel = response;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
