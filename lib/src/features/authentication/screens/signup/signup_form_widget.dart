import 'package:attendifyx/src/features/authentication/controllers/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';import 'package:get/get_core/src/get_main.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';
class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final _formKey = GlobalKey<FormState>();
    return Container(
      child: Form(
        key: _formKey,
          child: Container(
            padding:
            EdgeInsets.symmetric(vertical: tFormHeight - 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: controller.fullName,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                          Icons.person_outline_outlined),
                      labelText: "Full Name",
                      hintText: "Full Name",
                      border: OutlineInputBorder()),
                ),
                const SizedBox(height: tFormHeight - 20),
                TextFormField(
                  controller: controller.email,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email_outlined),
                      labelText: "Email",
                      hintText: "Email",
                      border: OutlineInputBorder()
                  ),
                ),
                const SizedBox(height: tFormHeight - 20),
                TextFormField(
                  controller: controller.phoneNo,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.numbers),
                      labelText: "Phone Number",
                      hintText: "Phone Number",
                      border: OutlineInputBorder()
                  ),
                ),
                const SizedBox(height: tFormHeight - 20),
                TextFormField(
                  controller: controller.password,
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
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          if(_formKey.currentState!.validate()){
                            SignUpController.instance.registerUser(controller.email.text.trim(), controller.password.text.trim());
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(),
                            backgroundColor: secondaryColor,
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: secondaryColor),
                            padding: const EdgeInsets.symmetric(
                                vertical: tButtonHeight)),
                        child: Text(
                          tSignUp.toUpperCase(),
                        ))),
              ],
            ),
          )),
    );
  }
}