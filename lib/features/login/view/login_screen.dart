import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/login_controller.dart';
import '../repository/validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: SafeArea(
            child: Scaffold(
          body: Container(
            padding: EdgeInsets.only(top: 10, left: 15, right: 15),
            color: Colors.white,
            child: Form(
              key: loginController.formKey.value,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: loginController.username.value,
                    validator: (value) => Validator.validateInput(input: value),
                    style: TextStyle(
                      // Customize text style here
                      color: Colors.black, // for example
                      fontSize: 16, // for example
                      // Add other text style properties as needed
                    ),
                    decoration: InputDecoration(
                      // Add border properties here
                      border: OutlineInputBorder(
                        // Customize border properties here
                        borderSide: BorderSide(
                          color: Colors.grey, // Border color
                          width: 1.0, // Border width
                        ),
                        borderRadius:
                            BorderRadius.circular(8.0), // Border radius
                      ),
                      // Optionally, add placeholder text
                      hintText: 'Name',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: loginController.password.value,
                    validator: (value) => Validator.validateInput(input: value),
                    style: TextStyle(
                      // Customize text style here
                      color: Colors.black, // for example
                      fontSize: 16, // for example
                      // Add other text style properties as needed
                    ),
                    decoration: InputDecoration(
                      // Add border properties here
                      border: OutlineInputBorder(
                        // Customize border properties here
                        borderSide: BorderSide(
                          color: Colors.grey, // Border color
                          width: 1.0, // Border width
                        ),
                        borderRadius:
                            BorderRadius.circular(8.0), // Border radius
                      ),
                      // Optionally, add placeholder text
                      hintText: 'Password',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (loginController.formKey.value.currentState!
                            .validate()) {
                          loginController.loginUser(
                              username: loginController.username.value.text,
                              password: loginController.password.value.text);
                        }
                      },
                      child: Text("Login"))
                ],
              ),
            ),
          ),
        )));
  }
}
