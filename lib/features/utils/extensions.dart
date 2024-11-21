import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_machine_test/features/resources/color_resources.dart';

class Utils {
  Utils._();

  static String getFormatedString({required DateTime date, String? formate}) {
    return DateFormat(formate ?? 'dd-MM-yyyy').format(date);
  }
  
  static Widget buildDropdownField({
    required String label,
    required String hint,
    required List<String> options,
    required String? selectedValue,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        DropdownButtonFormField<String>(
          value: selectedValue,
          hint: Text(hint),
          icon: const SizedBox.shrink(),
          decoration: InputDecoration(
            filled: true,
            suffixIcon: const Icon(Icons.keyboard_arrow_down, color: ColorResources.primaryColor),
            fillColor: ColorResources.ligthgrey.withOpacity(0.4),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          items: options
              .map((option) => DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
