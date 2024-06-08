// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as https;
import 'package:third_eye_task/models/forgot_password_mc.dart';
import 'package:third_eye_task/models/login_mc.dart';
import 'package:third_eye_task/models/otp_verification_mc.dart';
import 'package:third_eye_task/models/signup_mc.dart';
import 'package:third_eye_task/models/update_password.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiProvider {
  String baseUrl = 'https://eminent.host/testing/weightloser/api';

//! SignUp API call
  Future signUpUser(SignUpMc signUpMc) async {
    var apiUrl = Uri.parse('$baseUrl/authentication/signup.php');

    try {
      var response = await https.post(apiUrl,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(signUpMc.toJson()));

      log("signup status: ${response.statusCode.toString()}");
      log("signup body: ${response.body.toString()}");

      if (response.statusCode == 200) {
        var responseDecoded = jsonDecode(response.body);

        var message = responseDecoded['message'];
        int userId = responseDecoded['user_data']['user_id'];
        var token = responseDecoded['user_data']['user_token'];
        log('userId: $userId');
        log('message: $message');
        log('token: $token');

        return {'success': true, 'message': message};
      } else if (response.statusCode == 409) {
        var decoded = jsonDecode(response.body);

        return {'success': false, 'message': decoded['error']};
      } else {
        return {'success': false, 'message': 'Signup failed'};
      }
    } catch (e) {
      log("error ${e.toString()}");
    }
  }

//! Login API call
  Future loginUser(LoginMc loginMc) async {
    var apiUrl = Uri.parse("$baseUrl/authentication/login.php");

    try {
      var response = await https.post(apiUrl,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(loginMc.toJson()));

      log("login status code: ${response.statusCode.toString()}");
      log("login body: ${response.body.toString()}");

      if (response.statusCode == 200) {
        var responseDecoded = jsonDecode(response.body);

        var message = responseDecoded['message'];
        int userId = responseDecoded['user_data']['user_id'];
        var userEmail = responseDecoded['user_data']['user_email'];

        log('userId: $userId');
        log('message: $message');
        log('token: $userEmail');

        //! Store user ID
        SharedPreferences loginPrefs = await SharedPreferences.getInstance();
        await loginPrefs.setString('loginId', userId.toString());
        await loginPrefs.setString('userEmail', userEmail);

        return {'success': true, 'message': message};
      } else if (response.statusCode == 404) {
        var decoded = jsonDecode(response.body);

        return {'success': false, 'message': decoded['error']};
      } else {
        return {'success': false, 'message': 'Signup failed'};
      }
    } catch (e) {
      log('error: ${e.toString}');
    }
  }

//! Forget Password API call
  Future forgetPassword(ForgetPasswordMc forgetPasswordMc) async {
    var apiUrl = Uri.parse("$baseUrl/authentication/forget-password.php");

    try {
      var response = await https.post(apiUrl,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(forgetPasswordMc.toJson()));

      log("forgetPassword status code: ${response.statusCode.toString()}");
      log("forgetPassword body: ${response.body.toString()}");

      if (response.statusCode == 200) {
        var responseDecoded = jsonDecode(response.body);
        var message = responseDecoded['message'];

        return {'success': true, 'message': message};
      } else if (response.statusCode == 404) {
        var decoded = jsonDecode(response.body);

        return {'success': false, 'message': decoded['error']};
      } else {
        return {'success': false, 'message': 'Failed'};
      }
    } catch (e) {
      log('error: ${e.toString}');
    }
  }

//! otpVerification API call
  Future otpVerification(OptVerificationMc optVerificationMc) async {
    var apiUrl = Uri.parse("$baseUrl/authentication/otp-verify.php");

    try {
      var response = await https.post(apiUrl,
          body: jsonEncode(optVerificationMc.toJson()));

      log("optVerification status code: ${response.statusCode.toString()}");
      log("optVerification body: ${response.body.toString()}");

      if (response.statusCode == 200) {
        var responseDecoded = jsonDecode(response.body);

        var message = responseDecoded['message'];

        log('message: $message');

        return {'success': true, 'message': message};
      } else if (response.statusCode == 404) {
        var decoded = jsonDecode(response.body);

        return {'success': false, 'message': decoded['error']};
      } else if (response.statusCode == 400) {
        var decoded = jsonDecode(response.body);
        return {'success': false, 'message': decoded['error']};
      } else {
        return {'success': false, 'message': 'Signup failed'};
      }
    } catch (e) {
      log('error: ${e.toString}');
    }
  }

//! otpVerification API call
  Future updatePassword(UpdatePasswordMc updatePasswordMc) async {
    var apiUrl = Uri.parse("$baseUrl/authentication/update-password.php");

    try {
      var response =
          await https.post(apiUrl, body: jsonEncode(updatePasswordMc.toJson()));

      log("updatePasswordMc status code: ${response.statusCode.toString()}");
      log("updatePasswordMc body: ${response.body.toString()}");
      var decoded = jsonDecode(response.body);
      var message = decoded['message'];

      if (response.statusCode == 200) {
        return message;
      } else {
        log("signup status: ${response.statusCode.toString()}");
        throw Exception('Failed to update password: $message');
      }
    } catch (e) {
      log('error: ${e.toString}');
    }
  }
}
