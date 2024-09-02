import 'package:attendifyx/src/features/core/screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';
class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: tFormHeight - 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person_outline_outlined),
                    labelText: "Email",
                    hintText: "Email",
                    border: OutlineInputBorder()),
              ),
              const SizedBox(height: tFormHeight - 20),
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.fingerprint_rounded),
                  labelText: "Password",
                  hintText: "Password",
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                      onPressed: null,
                      icon: Icon(Icons.remove_red_eye_sharp)),
                ),
              ),
              const SizedBox(height: tFormHeight - 20),
              Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {},
                      child: Text("Forgot Password ?"))),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => Get.to(() => const Dashboard()),
                      style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(),
                          backgroundColor: secondaryColor,
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: secondaryColor),
                          padding: const EdgeInsets.symmetric(
                              vertical: tButtonHeight)),
                      child: Text(
                        tLogin.toUpperCase(),
                      ))),
            ],
          ),
        ));
  }
}