import 'package:flutter/material.dart';
import 'package:project_machine_test/features/page/auth/controller/login_controller.dart';
import 'package:project_machine_test/features/page/booking/controller/booking.dart';
import 'package:project_machine_test/features/page/register/controller/branch_list_controller.dart';
import 'package:project_machine_test/features/page/register/controller/register_controller.dart';
import 'package:project_machine_test/features/page/register/controller/treatment_controller.dart';
import 'package:project_machine_test/features/page/splash/splash_screen.dart';
import 'package:project_machine_test/features/resources/color_resources.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<RegisterState>(create: (context) => RegisterState()),
        ChangeNotifierProvider<TreatmentState>(create: (context) => TreatmentState()),
        ChangeNotifierProvider<LoginState>(create: (context) => LoginState()),
        ChangeNotifierProvider<PatientListState>(create: (context) => PatientListState()),
        ChangeNotifierProvider<BranchListState>(create: (context) => BranchListState()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ColorResources.primaryColor),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
