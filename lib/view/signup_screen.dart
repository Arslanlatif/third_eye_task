// ignore_for_file: use_build_context_synchronously

 
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neopop/neopop.dart';
import 'package:third_eye_task/controller/api_provider.dart';
import 'package:third_eye_task/controller/validatorMixin/validator_mixin.dart';
import 'package:third_eye_task/models/signup_mc.dart';
import 'package:third_eye_task/view/forgot_password_screen.dart';
import 'package:third_eye_task/view/login_screen.dart';
import '../controller/ScreenBasicElements/ScreenBasicElements.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with FormValidationMixin, SingleTickerProviderStateMixin {
  late TextEditingController _emailTEC, _passwordTEC, _userNameTEC;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late AnimationController animationController;
  late Animation<Offset> offsetAnimation;

  ApiProvider apiProvider = ApiProvider();

  @override
  void initState() {
    super.initState();
    _passwordTEC = TextEditingController();
    _emailTEC = TextEditingController();
    _userNameTEC = TextEditingController();

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
    _passwordTEC.dispose();
    animationController.dispose();
    super.dispose();
  }

  bool _obsecure = true;
  void _isVisible() {
    setState(() {
      _obsecure = !_obsecure;
    });
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
                          left: screenWidth * 0.07, right: screenWidth * 0.07),
                      child: Text(
                        'Create Account',
                        style: TextStyle(
                            fontSize: screenHeight * 0.036,
                            fontWeight: FontWeight.bold),
                      ),
                    ),

                    // ! UserName TextFormField
                    Padding(
                      padding: EdgeInsets.only(
                          top: screenHeight * 0.1,
                          left: screenWidth * 0.07,
                          right: screenWidth * 0.07),
                      child: SlideTransition(
                        position: offsetAnimation,
                        child: TextFormField(
                          controller: _userNameTEC,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.black,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: nameValidation,
                          decoration: InputDecoration(
                            fillColor: Colors.white10,
                            prefixIconColor: Colors.grey,
                            prefixIcon: const Icon(Icons.person),
                            filled: true,
                            label: Text(
                              'UserName',
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

                    // ! Email TextFormField
                    Padding(
                      padding: EdgeInsets.only(
                          top: screenHeight * 0.02,
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

                    // ! Password TextFormField
                    Padding(
                      padding: EdgeInsets.only(
                          top: screenHeight * 0.02,
                          left: screenWidth * 0.07,
                          right: screenWidth * 0.07),
                      child: SlideTransition(
                        position:
                            Tween(begin: const Offset(1, 0), end: Offset.zero)
                                .animate(animationController),
                        child: TextFormField(
                          controller: _passwordTEC,
                          obscureText: _obsecure,
                          cursorColor: Colors.black,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: paswodValidation,
                          decoration: InputDecoration(
                            prefixIconColor: Colors.grey,
                            prefixIcon: const Icon(Icons.lock),
                            fillColor: Colors.white,
                            filled: true,

                            //! Password Hide or Unhide
                            suffixIcon: IconButton(
                                color: Colors.black,
                                onPressed: () => _isVisible(),
                                icon: Icon(_obsecure
                                    ? Icons.visibility_off
                                    : Icons.visibility)),
                            label: Text(
                              'Password',
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                            labelStyle: TextStyle(height: screenHeight * 0.006),

                            // ! All borders
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blue.shade700,
                                ),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(screenWidth * 0.004))),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(screenWidth * 0.01))),
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(screenWidth * 0.004))),
                            errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(screenWidth * 0.004))),
                          ),
                        ),
                      ),
                    ),

                    //! Forgot Password Button
                    InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ForgotPasswordScreen(),
                      )),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: screenHeight * 0.023,
                            left: screenWidth * 0.52),
                        child: const Text('Forgot Password?',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),

                    // ! Sign Up/CONTINUE Button
                    Padding(
                        padding: EdgeInsets.only(
                            top: screenHeight * 0.04,
                            left: screenWidth * 0.07,
                            right: screenWidth * 0.07),
                        child: Container(
                          height: screenHeight * 0.1,
                          color: Colors.white,
                          child: NeoPopTiltedButton(
                              onTapUp: () {},
                              onTapDown: () async {
                                if (formKey.currentState!.validate()) {
                                  var response = await apiProvider.signUpUser(
                                      SignUpMc(
                                          userName: _userNameTEC.text,
                                          userEmail: _emailTEC.text,
                                          userPassword: _passwordTEC.text));

                                  if (response['success']) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text("Signup Successful")));

                                    _userNameTEC.clear();
                                    _emailTEC.clear();
                                    _passwordTEC.clear();

                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => const Logincreen(),
                                    ));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content:
                                                Text(response['message'])));
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('Signup Unsuccessful')));
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
                                  'Sign Up',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: screenHeight * 0.03),
                                ),
                              )),
                        )),

                    //! Login Button
                    InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Logincreen(),
                      )),
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: screenHeight * 0.03,
                        ),
                        child: const Text('Already have account? Login now.',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
