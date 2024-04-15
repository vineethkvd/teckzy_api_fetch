import 'dart:convert';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../core/api_endpoints.dart';
import '../../../core/cache_helper.dart';
import '../model/login_model.dart';
import 'package:flutter/material.dart';

class LoginController extends GetxController {
  var loginModel = LoginModel().obs;
  final Rx<GlobalKey<FormState>> _formKey = GlobalKey<FormState>().obs;

  Rx<GlobalKey<FormState>> get formKey => _formKey;
  final Rx<TextEditingController> username = TextEditingController().obs;
  final Rx<TextEditingController> password = TextEditingController().obs;
  Future<void> loginUser({
    required String username,
    required String password,
  }) async {
    const apiUrl =
        ApiEndPoints.baseURL + ApiEndPoints.auth + ApiEndPoints.login;
    final headers = {'Content-Type': 'application/json'};
    final requestData = {
      "username": username.trim(),
      "password": password.trim()
    };
    final jsonBody = json.encode(requestData);
    try {
      final response =
          await http.post(Uri.parse(apiUrl), headers: headers, body: jsonBody);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        loginModel(LoginModel.fromJson(responseData));
        CacheHelper.saveData(
            key: "loginToken", value: "${loginModel.value.token}");
        Get.defaultDialog(
          backgroundColor: Colors.white,
          title: 'Success',
          textConfirm: 'Ok',
          middleText: 'Login Successfully',
          titleStyle: TextStyle(
            fontSize: 18.sp, // Adjust the font size as needed
            fontWeight: FontWeight.bold, // Adjust the font weight as needed
          ),
          buttonColor: Colors.redAccent, // Set the button color
          radius: 10.0, // Set the border radius
          onConfirm: () {
            Get.back();
          },
        );
      } else if (response.statusCode == 400) {
        Get.defaultDialog(
          backgroundColor: Colors.white,
          title: 'Failed',
          textConfirm: 'Ok',
          middleText: 'Login failed',
          titleStyle: TextStyle(
            fontSize: 18.sp, // Adjust the font size as needed
            fontWeight: FontWeight.bold, // Adjust the font weight as needed
          ),
          buttonColor: Colors.redAccent, // Set the button color
          radius: 10.0, // Set the border radius
          onConfirm: () {
            Get.back();
          },
        );
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
