import 'package:CheckBox/src/controller/controller.dart';
import 'package:CheckBox/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find<UserController>();

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Sign In',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SignInForm(userController: userController),
      ),
    );
  }
}
