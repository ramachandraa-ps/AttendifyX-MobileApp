import 'package:attendifyx/src/constants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../core/screens/dashboard/dashboard.dart';
import '../../controllers/auth_controller.dart'; // Adjust import based on your file structure

class LoginForm extends StatelessWidget {
  final AuthController authController = Get
      .find(); // Ensure controller is correctly initialized

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0), // Adjusted padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: authController.emailController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person_outline_outlined),
                labelText: "Email",
                hintText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0), // Adjusted spacing
            TextFormField(
              controller: authController.passwordController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.fingerprint_rounded),
                labelText: "Password",
                hintText: "Password",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    // Handle password visibility toggle
                  },
                  icon: Icon(Icons.remove_red_eye_sharp),
                ),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16.0), // Adjusted spacing
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Handle forgot password
                },
                child: Text("Forgot Password?"),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  // Authentication logic here
                  final email = authController.emailController.text.trim();
                  final password = authController.passwordController.text
                      .trim();
                  try {
                    await authController.login(email, password);
                    // Navigate to the dashboard or handle successful login
                    Get.to(() => const Dashboard());
                  } catch (e) {
                    // Handle authentication error
                    print("Login error: $e");
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(),
                  backgroundColor: secondaryColor, // Example color
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: Text(
                  "Login".toUpperCase(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
