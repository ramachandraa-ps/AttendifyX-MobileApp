import 'package:attendifyx/src/constants/colors.dart';
import 'package:attendifyx/src/constants/image_strings.dart';
import 'package:attendifyx/src/constants/sizes.dart';
import 'package:attendifyx/src/features/authentication/screens/login/login_header_widget.dart';
import 'package:attendifyx/src/features/authentication/screens/signup/signup_footer_widget.dart';
import 'package:attendifyx/src/features/authentication/screens/signup/signup_form_widget.dart';
import 'package:attendifyx/src/features/authentication/screens/signup/signup_header_widget.dart';
import 'package:flutter/material.dart';

import '../../../../constants/text_strings.dart';
import '../../../../constants/text_styles.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

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
                        SignUpHeaderWidget(size: size),
                        SignUpFormWidget(),
                        SignUpFooterWidget()
                      ])
              )
          )
      ),
    );
  }
}

