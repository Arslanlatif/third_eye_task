// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neopop/widgets/buttons/neopop_tilted_button/neopop_tilted_button.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:third_eye_task/controller/api_provider.dart';
import 'package:third_eye_task/models/otp_verification_mc.dart';
import 'package:third_eye_task/view/home_screen.dart';
import '../controller/ScreenBasicElements/ScreenBasicElements.dart';

class OtpAuthentication extends StatefulWidget {
  const OtpAuthentication({super.key});

  @override
  State<OtpAuthentication> createState() => _OtpAuthenticationState();
}

class _OtpAuthenticationState extends State<OtpAuthentication>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> offsetAnimation;

  TextEditingController otpController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final ApiProvider _apiProvider = ApiProvider();

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    offsetAnimation = Tween(begin: const Offset(1, 0), end: Offset.zero)
        .animate(animationController)
      ..addListener(() {
        setState(() {});
      });
    animationController.forward();
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String otpCode = otpController.text.trim();

    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(systemNavigationBarColor: Colors.white),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 30,
          backgroundColor: Colors.white,
          title: const Text('OTP Verification'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Text for Varification
              Padding(
                padding: EdgeInsets.only(
                    top: screenHeight * 0.2,
                    left: screenWidth * 0.07,
                    right: screenWidth * 0.07),
                child: Text(
                  'Varification',
                  style: TextStyle(
                      fontSize: screenHeight * 0.05,
                      fontWeight: FontWeight.bold),
                ),
              ),

              // Simple Text
              Padding(
                padding: EdgeInsets.only(
                    top: screenHeight * 0.03,
                    left: screenWidth * 0.07,
                    right: screenWidth * 0.07),
                child: Text(
                  'Enter OTP that we have send to your Email',
                  style: TextStyle(fontSize: screenHeight * 0.03),
                ),
              ),

              // ! TextField for OTP
              SlideTransition(
                position: offsetAnimation,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.05,
                    left: screenWidth * 0.07,
                    right: screenWidth * 0.07,
                  ),
                  child: PinCodeTextField(
                    pinBoxWidth: screenWidth * 0.1,
                    pinBoxHeight: screenHeight * 0.08,
                    autofocus: false,
                    isCupertino: true,
                    highlight: true,
                    maxLength: 4,
                    keyboardType: TextInputType.number,
                    pinBoxColor: Colors.white,
                    errorBorderColor: Colors.red,
                    controller: otpController,
                    highlightColor: Colors.black,
                    defaultBorderColor: Colors.black,
                    hasTextBorderColor: Colors.grey,
                    pinBoxDecoration:
                        ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                    pinTextStyle: const TextStyle(fontSize: 22.0),
                    onDone: (pin) {
                      if (pin == otpCode) {
                        const Center(child: CircularProgressIndicator());
                      } else {
                        'Invalid OTP';
                      }
                    },
                  ),
                ),
              ),

              //! Continue Button
              Padding(
                  padding: EdgeInsets.only(
                      top: screenHeight * 0.05,
                      left: screenWidth * 0.07,
                      right: screenWidth * 0.07),
                  child: Container(
                    height: screenHeight * 0.1,
                    color: Colors.white,
                    child: NeoPopTiltedButton(
                        isFloating: true,
                        decoration: NeoPopTiltedButtonDecoration(
                            showShimmer: true,
                            plunkColor: const Color.fromARGB(255, 10, 95, 145),
                            shadowColor: Colors.black.withOpacity(0.3),
                            color: const Color.fromARGB(255, 0, 77, 139)),
                        onTapUp: () {},
                        onTapDown: () async {
                          if (otpController.text.isNotEmpty &&
                              otpController.text.length == 4) {
                            var response = await _apiProvider.otpVerification(
                                OptVerificationMc(userOtp: otpController.text));

                            if (response['success']) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(response['message'])));

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const HomeScreen()));
                              otpController.clear();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(response['message'])));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Fields can not be empty or less then 4')));
                          }
                        },
                        child: Center(
                          child: Text(
                            'Continue',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: screenHeight * 0.03),
                          ),
                        )),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
