import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project_machine_test/features/page/auth/controller/login_controller.dart';
import 'package:project_machine_test/features/page/booking/presentation/booking_screen.dart';
import 'package:project_machine_test/features/page/customs/bottom_button.dart';
import 'package:project_machine_test/features/page/customs/text_field.dart';
import 'package:project_machine_test/features/resources/color_resources.dart';
import 'package:project_machine_test/features/resources/image_resources.dart';
import 'package:project_machine_test/features/utils/snack_bar.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginState>(
      builder: (context, loginProvider, child) {
        void userHave() {
          showSnackBar(context, "authentication successful");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const BookingListScreen()),
          );
        }

        void userNotHave() {
          showSnackBar(context, "Check Your Email and password");
        }

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (loginProvider.user != null) {
            loginProvider.user?.status == true ? userHave() : userNotHave();
          }
        });

        return Scaffold(
          backgroundColor: ColorResources.whiteColor,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(ImageResources.login),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: Image.asset(
                      ImageResources.logo,
                      height: 80,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      const Text(
                        "Login Or Register To Book\nYour Appointments",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 40),
                      CustomTextFormField(
                        hintText: "Enter your email",
                        istitle: true,
                        title: "Email",
                        controller: loginProvider.usernameController,
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        hintText: "Enter password",
                        obscureText: true,
                        istitle: true,
                        title: "Password",
                        controller: loginProvider.passwordController,
                      ),
                      const SizedBox(height: 30),
                      if (loginProvider.isLoading)
                        const CircularProgressIndicator()
                      else
                        BottomButton(
                          title: "Login",
                          onPressed: () {
                            final username = loginProvider.usernameController.text;
                            final password = loginProvider.passwordController.text;
                            log("Post data: $username and $password");

                            if (username.isNotEmpty && password.isNotEmpty) {
                              loginProvider.login();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Enter valid credentials")),
                              );
                            }
                          },
                        ),
                      if (loginProvider.error != null)
                        Text(
                          loginProvider.error!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: const Padding(
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 24),
            child: Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                children: [
                  TextSpan(text: 'By creating or logging into an account you are agreeing with our', style: TextStyle(fontSize: 12)),
                  TextSpan(
                    text: ' Terms and Conditions',
                    style: TextStyle(fontWeight: FontWeight.bold, color: ColorResources.bluecolor, fontSize: 12),
                  ),
                  TextSpan(text: ' and'),
                  TextSpan(
                    text: ' Privacy Policy',
                    style: TextStyle(fontWeight: FontWeight.bold, color: ColorResources.bluecolor, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
