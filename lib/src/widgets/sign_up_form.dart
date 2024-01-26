import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/routes.dart';
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
          Get.toNamed(Routes.home);
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
            decoration: const InputDecoration(
              labelText: 'Username',
              border: OutlineInputBorder(),
            ),
            onSaved: (value) => _username = value ?? '',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a username';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Display Name',
              border: OutlineInputBorder(),
            ),
            onSaved: (value) => _displayName = value ?? '',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a display name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
            onSaved: (value) => _email = value ?? '',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an email';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
            ),
            obscureText: true,
            onSaved: (value) => _password = value ?? '',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a password';
              }
              return null;
            },
          ),
          const SizedBox(height: 24.0),
          ElevatedButton(
            onPressed: submitForm,
            child: const Text('Sign Up'),
          ),
        ],
      ),
    );
  }
}
