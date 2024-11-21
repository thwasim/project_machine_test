import 'dart:async';
import 'package:flutter/material.dart';
import 'package:project_machine_test/features/page/auth/presentation/login_screen.dart';
import 'package:project_machine_test/features/page/booking/presentation/booking_screen.dart';
import 'package:project_machine_test/features/resources/image_resources.dart';
import 'package:project_machine_test/features/resources/pref_resources.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    checkUserLoggedIn(context);
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Image.asset(ImageResources.splashPng, fit: BoxFit.cover),
      ),
    );
  }

  Future<void> checkUserLoggedIn(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final tocken = prefs.getString(PrefResources.USER_TOCKEN);
    if (tocken != null) {
      Timer(const Duration(seconds: 3), () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => const BookingListScreen())));
    } else {
      Timer(const Duration(seconds: 3), () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => const LoginScreen())));
    }
  }
}
