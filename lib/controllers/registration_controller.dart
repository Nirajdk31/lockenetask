import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:email_auth/email_auth.dart';
import '../screens/homescreen.dart';

class RegistrationController extends GetxController {
  final name = ''.obs;
  final businessName = ''.obs;
  final email = ''.obs;
  final password = ''.obs;
  final otp = ''.obs;

  // API URLs
  final otpApiUrl = 'https://fsm.mistrichacha.com/Fsm/SendOtpToServicePartner';
  final registrationApiUrl = 'https://fsm.mistrichacha.com/Fsm/registerFsm';

  // API Headers
  final Map<String, String> apiHeaders = {
    'Client-Service': 'Client-Service',
    'Auth-Key': 'ExVfMAc9A8vQcE3zY0',
  };


  // Function to send OTP
  Future<void> sendOTP() async {


    try {
      final encoding = Encoding.getByName('utf-8');
      final response = await http.post(
        Uri.parse(otpApiUrl),

        headers: apiHeaders,
        encoding: encoding,
        body: {
          'language': 'en',
          'name': name.value,
          'business_name': businessName.value,
          'email': email.value,
          'password': password.value,
        },
      );

      if (response.statusCode == 200) {
        // OTP sent successfully, handle the response
        final json = jsonDecode(response.body);
        print(json);
      }
        //print("DATA: ${json}");

        // Get.showSnackbar(
        //   const GetSnackBar(
        //    // title: title,
        //     message: 'Otp Verified',
        //     icon: Icon(Icons.refresh),
        //     duration: Duration(seconds: 3),
        //   ),
        // );
        // Get.to(HomePage());
      // } else {
      //   // Handle API error
      //   //throw jsonDecode(response.body)["Message"]??"Unknown Error Occurred";
      //   Get.showSnackbar(
      //     const GetSnackBar(
      //       // title: title,
      //       message: 'Otp not Verified',
      //       icon: Icon(Icons.refresh),
      //       duration: Duration(seconds: 3),
      //     ),
      //   );
      // }
    } catch (error) {
      // Handle network error
      Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text('Error'),
              contentPadding: EdgeInsets.all(20),
              children: [Text(error.toString())],
            );
          }
      );
    }
  }

  // Function to register and verify OTP
  Future<void> registerAndVerifyOTP() async {
    try {
      final response = await http.post(
        Uri.parse(registrationApiUrl),
        headers: apiHeaders,
        body: {
          'name': name.value,
          'business_name': businessName.value,
          'email': email.value,
          'password': password.value,
          'otp': otp.value,
        },
      );

      if (response.statusCode == 200) {
        // Registration and OTP verification successful, handle the response
        final responseJson = json.decode(response.body);
      } else {
        // Handle API error
      }
    } catch (error) {
      // Handle network error
    }
  }
}
