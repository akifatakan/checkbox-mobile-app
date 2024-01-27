import 'package:CheckBox/src/commons/commons.dart';
import 'package:CheckBox/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/routes.dart';
import '../controller/controller.dart';

class SignInForm extends StatelessWidget {
  final UserController userController;

  SignInForm({Key? key, required this.userController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    String _email = '';
    String _password = '';

    void submitForm() async {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        await userController.signInWithCredentials(_email, _password);
        if (userController.isUserSignedIn.value) {
          Get.offAllNamed(Routes.welcome);
        } else {
          Get.snackbar('Error', 'Sign in failed',
              snackPosition: SnackPosition.BOTTOM);
        }
      }
    }

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(height: 16.0),
          TextFormField(
            decoration: AuthInputDecoration.getDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
            onSaved: (value) => _email = value ?? '',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an email';
              }
              return null;
            },
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            decoration:
                AuthInputDecoration.getDecoration(labelText: 'Password'),
            obscureText: true,
            onSaved: (value) => _password = value ?? '',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a password';
              }
              return null;
            },
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 24.0),
          AuthButton(onPressed: submitForm, label: 'Sign In')
        ],
      ),
    );
  }
}
