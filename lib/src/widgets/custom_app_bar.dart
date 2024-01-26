import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const CustomAppBar({Key? key, required this.title, this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black, // AppBar background color
      title: Text(
        title,
        style: const TextStyle(color: Colors.white), // Title text style
      ),
      actions: actions, // Additional actions for the AppBar
      iconTheme: const IconThemeData(color: Colors.white), // AppBar icon theme
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); // Default AppBar height
}
