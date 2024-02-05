import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../routes/routes.dart';
import '../controller/controller.dart';
import '../widgets/widgets.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({Key? key}) : super(key: key);
  final UserController _userController = Get.find<UserController>();
  final WelcomeScreenController _welcomeController =
      Get.find<WelcomeScreenController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.grey.shade900,
                  Colors.grey.shade800,
                  Colors.grey.shade700,
                ],
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(35),
                      child: Image.asset(
                        'lib/assets/checkbox_logo.png',
                        width: MediaQuery.of(context).size.width * 0.5,
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Welcome to CheckBox',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 50),
                    Obx(() {
                      if (_userController.isUserSignedIn.value) {
                        return _buildUserWelcomeSection();
                      } else {
                        return _buildAuthenticationOptions(context);
                      }
                    }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserWelcomeSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Hello, ${_userController.user.value?.displayName ?? 'Guest'}!',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        SizedBox(height: 20),
        Obx(() => Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 50.0), // Add horizontal padding
              child: ClipRRect(
                // Make corners rounded
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: SizedBox(
                  height: 10.0, // Set the height of the progress bar
                  child: LinearProgressIndicator(
                    value: _welcomeController.progressValue.value,
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white70),
                  ),
                ),
              ),
            )),
      ],
    );
  }

  Widget _buildAuthenticationOptions(BuildContext context) {
    // Add sign in/up options and Google authentication
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            Get.toNamed(Routes.signIn);
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.white, // Button color
            onPrimary: Colors.black, // Text color
          ),
          child: Text('Sign In'),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            Get.toNamed(Routes.signUp);
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.white, // Button color
            onPrimary: Colors.black, // Text color
          ),
          child: Text('Sign Up'),
        ),
        SizedBox(height: 30),
        OrDivider(color: Colors.white70),
        SizedBox(height: 30),
        ElevatedButton.icon(
          icon: Icon(FontAwesomeIcons.google, color: Colors.red),
          label: Text('Sign In with Google'),
          onPressed: _userController.signInWithGoogle,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white, // Button color
            foregroundColor: Colors.black, // Text color
          ),
        ),
      ],
    );
  }
}
