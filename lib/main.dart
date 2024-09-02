import 'package:attendifyx/firebase_options.dart';
import 'package:attendifyx/src/features/authentication/authentication_repository/authentication_repository.dart';
import 'package:attendifyx/src/features/authentication/controllers/auth_controller.dart';
import 'package:attendifyx/src/utils/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'src/features/authentication/screens/welcome/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Register AuthenticationRepository with GetX
  Get.put(AuthController());

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const WelcomeScreen(),
    );
  }
}
