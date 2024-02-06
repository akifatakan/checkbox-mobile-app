import 'package:CheckBox/src/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/routes.dart';
import '../widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final UserController _userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(),
      appBar: CustomAppBar(
        title: 'Profile',
      ),
      body: ListView(
        children: ListTile.divideTiles( // This adds a divider between list tiles.
          context: context,
          tiles: [
            ListTile(
              leading: Icon(Icons.done_all),
              title: Text('Completed Todos'),
              onTap: () {
                Get.toNamed(Routes.completedTodos);
              },
            ),
            ListTile(
              leading: Icon(Icons.hourglass_empty),
              title: Text('Overdue Todos'),
              onTap: () {
                Get.toNamed(Routes.overdueTodos);
              },
            ),
            ListTile(
              leading: Icon(Icons.password),
              title: Text('Change Password'),
              onTap: () {
                // Navigate to Change Password Screen
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Sign Out'),
              onTap: () {
                _userController.signOut();
                Get.offAllNamed(Routes.welcome);
              },
            ),
            Obx(() => ListTile(
              leading: Icon(Icons.fingerprint),
              title: Text('Biometric Authentication'),
              trailing: Switch(
                value: _userController.isBiometricEnabled.value,
                onChanged: (value) {
                  _userController.toggleBiometric(value);
                },
              ),
            )),
          ],
        ).toList(),
      ),    );
  }
}
