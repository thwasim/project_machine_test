import 'package:flutter/material.dart';
import 'package:project_machine_test/features/resources/color_resources.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final bool? obscureText;
  final bool? enabled;
  final bool? istitle;
  final String? title;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final void Function()? onTap;
  final bool? readOnly;
  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.obscureText = false,
    this.enabled,
    this.istitle = false,
    this.title,
    this.controller,
    this.readOnly = false,
    this.keyboardType,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        istitle == true
            ? Text(
                title.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              )
            : const SizedBox.shrink(),
        const SizedBox(height: 4),
        TextFormField(
          enabled: enabled,
          onTap: onTap,
          readOnly: readOnly ?? false,
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText ?? false,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: ColorResources.ligthgrey.withOpacity(0.4),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ],
    );
  }
}
