import 'package:flutter/material.dart';
import 'package:project_machine_test/features/resources/color_resources.dart';

class BottomButton extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  final bool? isIcon;
  final IconData? icon;
  final Color? backgroundColor;
  const BottomButton({super.key, this.onPressed, required this.title, this.isIcon = false, this.icon, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? ColorResources.primaryColor,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: isIcon == true
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.black),
                Text(
                  title.toString(),
                  style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            )
          : Text(
              title.toString(),
              style: const TextStyle(fontSize: 16, color: ColorResources.whiteColor, fontWeight: FontWeight.bold),
            ),
    );
  }
}
