import 'package:CheckBox/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/routes.dart';
import '../commons/commons.dart';
import '../controller/controller.dart';

class SignUpForm extends StatelessWidget {
  final UserController userController;

  SignUpForm({Key? key, required this.userController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    String _username = '';
    String _email = '';
    String _password = '';
    String _displayName = '';

    void submitForm() async {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        await userController.signUpWithCredentials(
            _email, _password, _username, _displayName);
        if (userController.isUserSignedIn.value) {
          Get.offAllNamed(Routes.welcome);
        } else {
          print('Error happened');
        }
      }
    }

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            decoration:
                AuthInputDecoration.getDecoration(labelText: 'Username'),
            onSaved: (value) => _username = value ?? '',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a username';
              }
              return null;
            },
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            decoration:
                AuthInputDecoration.getDecoration(labelText: 'Display Name'),
            onSaved: (value) => _displayName = value ?? '',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a display name';
              }
              return null;
            },
            style: TextStyle(color: Colors.white),
          ),
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
          AuthButton(onPressed: submitForm, label: 'Sign Up')
        ],
      ),
    );
  }
}
