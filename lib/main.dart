import 'package:attendifyx/src/utils/theme/theme.dart';
import 'package:flutter/material.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: AppHome(),
    );
  }
}

class AppHome extends StatelessWidget {
  const AppHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/logo/logo.png',
              width: 40.0,
              height: 40.0,
            ),
            SizedBox(width: 10.0),
            Text(
              "AttendifyX",
              style: TextStyle(
                fontFamily: 'Times New Roman',
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333), // Set text color to #333333
              ),
            ),
          ],
        ),
        // leading: const Icon(Icons.ondemand_video),
        backgroundColor: Color(0xFFFF7043), // Set AppBar color to #FF7043
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_shopping_cart),
        onPressed: () {},
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const Text("Heading"),
            const Text("Sub-heading"),
            const Text("Paragraph"),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Elevated Button"),
            ),
            OutlinedButton(
              onPressed: () {},
              child: const Text("Outlined Button"),
            ),
          ],
        ),
      ),
    );
  }
}
