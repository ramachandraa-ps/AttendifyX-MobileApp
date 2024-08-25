import 'package:flutter/material.dart';

import '../../../../constants/image_strings.dart';
import '../../../../constants/text_strings.dart';
import '../../../../constants/text_styles.dart';
class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({
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
            height: size.height * 0.35),
        Text(tLoginTitle, style: AppTextStyles.headline1),
        Text(
          tLoginSubTitle,
          style: AppTextStyles.bodyText2,
        ),
      ],
    );
  }
}
