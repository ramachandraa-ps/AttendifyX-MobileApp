import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../core/screens/dashboard/dashboard.dart';
import '../authentication_repository/authentication_repository.dart';
import '../exceptions/login_email_password_failure.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();

  void loginUser(String email, String password) async {
    try {
      await AuthenticationRepository.instance.loginWithEmailAndPassword(email, password);
      Get.offAll(() => Dashboard()); // Navigate to the Dashboard after successful login
    } catch (e) {
      if (e is LoginEmailPasswordFailure) {
        Get.snackbar('Login Error', e.message, snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar('Login Error', 'An unexpected error occurred.', snackPosition: SnackPosition.BOTTOM);
      }
    }
  }
}
