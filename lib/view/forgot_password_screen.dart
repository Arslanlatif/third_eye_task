// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neopop/neopop.dart';
import 'package:third_eye_task/controller/api_provider.dart';
import 'package:third_eye_task/controller/validatorMixin/validator_mixin.dart';
import 'package:third_eye_task/models/forgot_password_mc.dart';
import 'package:third_eye_task/view/otp_screen.dart';

import '../controller/ScreenBasicElements/ScreenBasicElements.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with FormValidationMixin, SingleTickerProviderStateMixin {
  late TextEditingController _emailTEC;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late AnimationController animationController;
  late Animation<Offset> offsetAnimation;

  final ApiProvider _apiProvider = ApiProvider();

  @override
  void initState() {
    super.initState();
    _emailTEC = TextEditingController();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    offsetAnimation = Tween(begin: const Offset(-1, 0), end: Offset.zero)
        .animate(animationController)
      ..addListener(() {
        setState(() {});
      });
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(systemNavigationBarColor: Colors.white),
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
          height: screenHeight,
          color: Colors.white,
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //  Simple Text
                    Padding(
                      padding: EdgeInsets.only(
                          top: screenHeight * 0.15,
                          left: screenWidth * 0.07,
                          right: screenWidth * 0.07),
                      child: Text(
                        'Enter email so that we can send you an OTP',
                        style: TextStyle(
                            fontSize: screenHeight * 0.03,
                            fontWeight: FontWeight.bold),
                      ),
                    ),

                    // ! Email TextFormField
                    Padding(
                      padding: EdgeInsets.only(
                          top: screenHeight * 0.1,
                          left: screenWidth * 0.07,
                          right: screenWidth * 0.07),
                      child: SlideTransition(
                        position: offsetAnimation,
                        child: TextFormField(
                          controller: _emailTEC,
                          keyboardType: TextInputType.emailAddress,
                          // autofocus: true,
                          cursorColor: Colors.black,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: emailValidation,
                          decoration: InputDecoration(
                            fillColor: Colors.white10,
                            prefixIconColor: Colors.grey,
                            prefixIcon: const Icon(Icons.email),
                            filled: true,
                            label: Text(
                              'Email',
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                            labelStyle: TextStyle(height: screenHeight * 0.006),

                            // ! All Borders
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 127, 189, 129),
                                ),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(screenWidth * 0.004))),
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(screenWidth * 0.004))),
                            errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(screenWidth * 0.004))),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(screenWidth * 0.004))),
                          ),
                        ),
                      ),
                    ),

                    // ! CONTINUE Button
                    Padding(
                        padding: EdgeInsets.only(
                            top: screenHeight * 0.05,
                            left: screenWidth * 0.07,
                            right: screenWidth * 0.07),
                        child: Container(
                          height: screenHeight * 0.1,
                          color: Colors.white,
                          child: NeoPopTiltedButton(
                              onTapUp: () {},
                              onTapDown: () async {
                                if (formKey.currentState!.validate()) {
                                  var response = await _apiProvider
                                      .forgetPassword(ForgetPasswordMc(
                                          userEmail: _emailTEC.text));

                                  if (response['success']) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content:
                                                Text(response['message'])));

                                    _emailTEC.clear();

                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const OtpAuthentication()));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content:
                                                Text(response['message'])));
                                  }
                                } else {
                                  const ScaffoldMessenger(
                                      child: SnackBar(
                                          content: Text('Unsuccesful')));
                                }
                              },
                              isFloating: true,
                              decoration: NeoPopTiltedButtonDecoration(
                                  showShimmer: true,
                                  plunkColor:
                                      const Color.fromARGB(255, 10, 95, 145),
                                  shadowColor: Colors.black.withOpacity(0.3),
                                  color: const Color.fromARGB(255, 0, 77, 139)),
                              child: Center(
                                child: Text(
                                  'Send OTP',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: screenHeight * 0.03),
                                ),
                              )),
                        )),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
