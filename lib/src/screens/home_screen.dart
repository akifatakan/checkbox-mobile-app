import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../routes/routes.dart';
import '../controller/controller.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final UserController _userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'CheckBox',
        actions: [
          IconButton(
            icon: Icon(Icons.add_box_outlined),
            onPressed: () {
              // Action when the add icon is pressed
            },
          ),
          Obx(() {
            if (_userController.isUserSignedIn.value) {
              return IconButton(
                icon: Icon(Icons.logout),
                onPressed: () => {
                  _userController.signOut(),
                  Get.offAllNamed(Routes.welcome)
                },
              );
            }
            return SizedBox.shrink();
          }),
        ],
      ),
      body: Center(
        child: Obx(() {
          if (_userController.isUserSignedIn.value) {
            UserModel? userModel = _userController.user.value;
            return userModel != null
                ? WelcomeUserSection(userModel: userModel)
                : UserNotAvailableSection();
          } else {
            return SignInOptionsSection();
          }
        }),
      ),
    );
  }
}

class WelcomeUserSection extends StatelessWidget {
  final UserModel userModel;

  const WelcomeUserSection({Key? key, required this.userModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Welcome, ${userModel.displayName}',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class UserNotAvailableSection extends StatelessWidget {
  const UserNotAvailableSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'User data not available',
      style: TextStyle(fontSize: 20, color: Colors.grey),
    );
  }
}

class SignInOptionsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Please sign in',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        SizedBox(height: 16),
        SignInButton(text: 'Sign In', route: Routes.signIn),
        SignInButton(text: 'Sign Up', route: Routes.signUp),
        SignInButton(
          text: 'Sign In with Google',
          icon: FontAwesomeIcons.google,
          color: Colors.red,
          onPressed: Get.find<UserController>().signInWithGoogle,
        ),
      ],
    );
  }
}

class SignInButton extends StatelessWidget {
  final String text;
  final String? route;
  final IconData? icon;
  final Color? color;
  final VoidCallback? onPressed;

  SignInButton({
    Key? key,
    required this.text,
    this.route,
    this.icon,
    this.color,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed ?? () => Get.toNamed(route!),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) Icon(icon, color: Colors.white),
          if (icon != null) SizedBox(width: 8),
          Text(text, style: TextStyle(color: Colors.white)),
        ],
      ),
      style: ElevatedButton.styleFrom(
        primary: color ?? Theme.of(context).primaryColor,
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        textStyle: TextStyle(fontSize: 16),
      ),
    );
  }
}
