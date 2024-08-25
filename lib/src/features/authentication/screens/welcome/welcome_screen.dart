import 'package:attendifyx/src/constants/image_strings.dart';
import 'package:attendifyx/src/constants/sizes.dart';
import 'package:attendifyx/src/constants/text_strings.dart';
import 'package:attendifyx/src/constants/text_styles.dart';
import 'package:flutter/material.dart';

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
      padding: EdgeInsets.all(tDefaultSize),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Image(
          image: AssetImage(tWelcomeScreenImage),
          height: height * 0.6,
        ),
        Column(
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
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(),
                        foregroundColor: secondaryColor,
                        side: BorderSide(color: secondaryColor),
                        padding: EdgeInsets.symmetric(vertical: tButtonHeight)),
                    child: Text(tLogin.toUpperCase()))),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(),
                        backgroundColor: secondaryColor,
                        foregroundColor: Colors.white,
                        side: BorderSide(color: secondaryColor),
                        padding: EdgeInsets.symmetric(vertical: tButtonHeight)),
                    child: Text(tSignUp.toUpperCase()))),
          ],
        )
      ]), // Column
    ) // Container
        ); // Scaffold
  }
}
