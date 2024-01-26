import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../routes/routes.dart';
import '../controller/controller.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final UserController _userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'CheckBox',
        actions: [
          IconButton(
            icon: Icon(Icons.add_box_outlined),
            onPressed: () {
              // Action when icon is pressed
            },
          )
        ],
      ),
      body: Center(
        child: Obx(() {
          if (_userController.isUserSignedIn.value) {
            // Make sure to access the 'value' property of 'user' to get the UserModel object
            UserModel? userModel = _userController.user.value;
            if (userModel != null) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome, ${userModel.displayName}', // Use userModel to access displayName
                    style: TextStyle(fontSize: 20),
                  ),
                  ElevatedButton(
                      onPressed: () => {_userController.signOut()},
                      child: Text('Sign Out'))
                ],
              );
            } else {
              // Handle the case when userModel is null
              return Text(
                'User data not available',
                style: TextStyle(fontSize: 20),
              );
            }
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Home Page', style: TextStyle(fontSize: 20)),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.signIn);
                  },
                  child: const Text('Sign In'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.signUp);
                  },
                  child: const Text('Sign Up'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () => {
                    _userController.signInWithGoogle(),
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(FontAwesomeIcons.google, color: Colors.white),
                      SizedBox(width: 5),
                      const Text('Sign In with Google',
                          style: TextStyle(color: Colors.white))
                    ],
                  ),
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
