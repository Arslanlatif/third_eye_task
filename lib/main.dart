import 'package:flutter/material.dart';
import 'package:third_eye_task/controller/ScreenBasicElements/ScreenBasicElements.dart';
import 'package:third_eye_task/view/signup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    initialize(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const SignUpScreen(),
    );
  }
}
