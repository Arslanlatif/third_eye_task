// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:third_eye_task/controller/ScreenBasicElements/ScreenBasicElements.dart';
import 'package:third_eye_task/view/update_password_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //! Get User ID
  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('loginId');
  }

  //! Get User email
  Future<String?> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userEmail');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeScreen'),
      ),
      body: const Center(child: Text('Welcome')),
      drawer: Drawer(
        child: Center(
          child: SizedBox(
            height: screenHeight * 0.1,
            width: screenWidth * 0.5,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
                onPressed: () async {
                  String? userId = await getUserId();
                  String? userEmail = await getUserEmail();

                  log("email ${userEmail.toString()}");
                  log('id ${userId.toString()}');

                  if (userId != null && userEmail != null) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => UpdatePasswordScreen(
                        userId: userId,
                        email: userEmail,
                      ),
                    ));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('UserId is null'),
                      ),
                    );
                  }
                },
                child: const Text(
                  'Update Password',
                  style: TextStyle(color: Colors.white),
                )),
          ),
        ),
      ),
    );
  }
}
