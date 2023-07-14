import 'package:flutter/material.dart';
import 'modules/screens/result_screen.dart';
import 'modules/screens/splash_screen.dart';
import 'modules/screens/upload_screen.dart';
import 'modules/screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DEFECTO',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => const SplashScreen(),
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        UploadScreen.id: (context) => const UploadScreen(),
        ResultScreen.id: (context) => ResultScreen(result: ""),
      },
    );
  }
}
