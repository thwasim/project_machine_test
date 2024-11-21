import 'package:flutter/material.dart';
import 'package:project_machine_test/features/page/customs/bottom_button.dart';
import 'package:project_machine_test/features/page/register/controller/treatment_controller.dart';
import 'package:project_machine_test/features/resources/color_resources.dart';
import 'package:provider/provider.dart';

class TreatmentDialog extends StatefulWidget {
  const TreatmentDialog({super.key});

  @override
  State<TreatmentDialog> createState() => _TreatmentDialogState();
}

class _TreatmentDialogState extends State<TreatmentDialog> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TreatmentState>(context, listen: false).fetchTreatments();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      content: Consumer<TreatmentState>(
        builder: (context, state, child) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.error != null) {
            return Text("Error: ${state.error}");
          }

          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Choose Treatment", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: state.selectedTreatment,
                isExpanded: true,
                items: state.treatments.map((treatment) {
                  return DropdownMenuItem<String>(
                    value: treatment['name'],
                    child: Text(
                      treatment['name'].toString(),
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  state.setSelectedTreatment(value!);
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 16, right: 16),
                  filled: true,
                  hintText: "Choose preferred treatment",
                  hintStyle: const TextStyle(fontSize: 12),
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text("Add Patients", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Expanded(child: Text("Male", style: TextStyle(fontWeight: FontWeight.w500))),
                  IconButton(
                    onPressed: state.maleCount > 0 ? state.decrementMale : null,
                    icon: const Icon(Icons.remove_circle, color: ColorResources.primaryColor),
                  ),
                  SizedBox(
                    width: 40,
                    child: Text(
                      state.maleCount.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    onPressed: state.incrementMale,
                    icon: const Icon(Icons.add_circle, color: ColorResources.primaryColor),
                  ),
                ],
              ),
              Row(
                children: [
                  const Expanded(child: Text("Female", style: TextStyle(fontWeight: FontWeight.w500))),
                  IconButton(
                    onPressed: state.femaleCount > 0 ? state.decrementFemale : null,
                    icon: const Icon(Icons.remove_circle, color: ColorResources.primaryColor),
                  ),
                  SizedBox(
                    width: 40,
                    child: Text(
                      state.femaleCount.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    onPressed: state.incrementFemale,
                    icon: const Icon(Icons.add_circle, color: ColorResources.primaryColor),
                  ),
                ],
              ),
            ],
          );
        },
      ),
      actions: [
        BottomButton(
          title: "Save",
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
