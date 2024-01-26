import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Home Page',
              style: TextStyle(fontSize: 20),
            ),
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
            Row(
              children: [Icon(FontAw)],
            )
          ],
        ),
      ),
    );
  }
}
