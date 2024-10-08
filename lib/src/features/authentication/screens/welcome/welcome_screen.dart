import 'package:attendifyx/src/constants/image_strings.dart';
import 'package:attendifyx/src/constants/sizes.dart';
import 'package:attendifyx/src/constants/text_strings.dart';
import 'package:attendifyx/src/constants/text_styles.dart';
import 'package:attendifyx/src/features/authentication/screens/login/login_screen.dart';
import 'package:attendifyx/src/features/authentication/screens/signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/colors.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;
    var brightness = mediaQuery.platformBrightness;
    return Scaffold(
        backgroundColor: primaryColor,
        body: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image(
                  image: const AssetImage(tWelcomeScreenImage),
                  height: height * 0.6,
                ),
                const Column(
                  children: [
                    Text(tWelcomeTitle, style: AppTextStyles.headline1),
                    Text(
                      tWelcomeSubTitle,
                      style: AppTextStyles.bodyText2,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: OutlinedButton(
                            onPressed: () => Get.to(() => const LoginScreen()),
                            style: OutlinedButton.styleFrom(
                                shape: const RoundedRectangleBorder(),
                                foregroundColor: secondaryColor,
                                side: const BorderSide(color: secondaryColor),
                                padding: const EdgeInsets.symmetric(
                                    vertical: tButtonHeight)),
                            child: Text(tLogin.toUpperCase()))),
                    const SizedBox(width: 10.0),
                    Expanded(
                        child: ElevatedButton(
                            onPressed: () => Get.to(() => const SignUpScreen()),
                            style: ElevatedButton.styleFrom(
                                shape: const RoundedRectangleBorder(),
                                backgroundColor: secondaryColor,
                                foregroundColor: Colors.white,
                                side: const BorderSide(color: secondaryColor),
                                padding: const EdgeInsets.symmetric(
                                    vertical: tButtonHeight)),
                            child: Text(tSignUp.toUpperCase()))),
                  ],
                )
              ]), // Column
        ) // Container
        ); // Scaffold
  }
}
