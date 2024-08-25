import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/image_strings.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';
import '../../../../constants/text_styles.dart';
class SignUpFooterWidget extends StatelessWidget {
  const SignUpFooterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
            label: Text(tSignInWithGoogle.toUpperCase()),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text.rich(TextSpan(
              text: "Already Have an  Account?  ",
              style: AppTextStyles.bodyText2,
              children: const [
                TextSpan(
                  text: tLogin,
                  style: TextStyle(color: Colors.blue),
                )
              ])),
        ),
      ],
    );
  }
}