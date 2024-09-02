import 'package:attendifyx/src/constants/colors.dart';
import 'package:attendifyx/src/constants/image_strings.dart';
import 'package:attendifyx/src/constants/sizes.dart';
import 'package:attendifyx/src/constants/text_styles.dart';
import 'package:flutter/material.dart';

import '../../../../constants/text_strings.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
          title: Text(tAppName, style: AppTextStyles.headline1),
          centerTitle: true,
          elevation: 0,
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 10, top: 7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10)
              ),
              child: IconButton(
                onPressed: () {},
                icon: ClipOval(
                  child: Image(
                    image: AssetImage(tUserIcon),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
            child: Container(
          padding: const EdgeInsets.all(tDashboardPadding),
              child: Column(
                children: [
                  Text("User Dashboard", style: AppTextStyles.headline2,)
                ],
              ),
        )
        ),
      ),
    );
  }
}
