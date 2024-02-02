import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  const AuthButton(
      {Key? key,
      required this.onPressed,
      required this.label,
      this.backgroundColor,
      this.foregroundColor})
      : super(key: key);
  final VoidCallback onPressed;
  final String label;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? Colors.white,
        // Button background color
        foregroundColor: foregroundColor ?? Colors.black87, // Button text color
      ),
      child: Text(label),
    );
  }
}
