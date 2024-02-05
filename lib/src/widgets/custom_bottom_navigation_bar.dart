import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/controller.dart';
import '../screens/screens.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationController = Get.find<NavigationController>();

    return Obx(
      () => BottomNavigationBar(
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.white.withOpacity(0.7),
        selectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: navigationController.currentIndex.value,
        onTap: (index) {
          navigationController.currentIndex.value = index;
          // Navigate to the respective page
          switch (index) {
            case 0:
              Get.offAll(() => HomeScreen());
              break;
            case 1:
              Get.offAll(() => SearchScreen());
              break;
            case 2:
              Get.offAll(() => CreateTodoScreen());
              break;
            case 3:
              Get.offAll(() => ProfileScreen());
              break;
            case 4:
              Get.offAll(() => NotificationsScreen());
              break;
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'Create'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Notifications'),
        ],
      ),
    );
  }
}
