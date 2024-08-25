import 'package:attendifyx/src/constants/image_strings.dart';
import 'package:attendifyx/src/constants/sizes.dart';
import 'package:attendifyx/src/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:attendifyx/src/constants/text_styles.dart';
import 'package:attendifyx/src/constants/text_styles.dart';

import '../../../../constants/colors.dart';
import 'login_form_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                    image: const AssetImage(tWelcomeScreenImage),
                    height: size.height * 0.35),
                Text(tLoginTitle, style: AppTextStyles.headline1),
                Text(
                  tLoginSubTitle,
                  style: AppTextStyles.bodyText2,
                ),

                // section 1 - end

                // section 2 [form]
                const LoginForm(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("OR"),
                    const SizedBox(
                      height: tFormHeight - 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        icon: const Image(
                          image: AssetImage(tGoogleLogoImage),
                          width: 20.0,
                        ),
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(),
                            side: const BorderSide(color: secondaryColor),
                            padding: const EdgeInsets.symmetric(
                                vertical: tButtonHeight)),
                        label: Text(tSignInWithGoogle),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text.rich(TextSpan(
                          text: "Don't Have an Account? ",
                          style: AppTextStyles.bodyText2,
                          children: const [
                            TextSpan(
                              text: tSignUp,
                              style: TextStyle(color: Colors.blue),
                            )
                          ])),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
