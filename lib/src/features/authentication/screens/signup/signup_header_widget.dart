import 'package:flutter/material.dart';

import '../../../../constants/image_strings.dart';
import '../../../../constants/text_strings.dart';
import '../../../../constants/text_styles.dart';
class SignUpHeaderWidget extends StatelessWidget {
  const SignUpHeaderWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(
            image: const AssetImage(tWelcomeScreenImage),
            height: size.height * 0.30),
        Text(tSignUpTitle, style: AppTextStyles.headline1),
        Text(
          tSignUpSubTitle,
          style: AppTextStyles.bodyText2,
        ),
      ],
    );
  }
}