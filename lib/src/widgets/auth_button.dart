import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({Key? key, required this.onPressed, required this.label})
      : super(key: key);
  final VoidCallback onPressed;
  final String label;
  final Color backgroundColor = Colors.white;
  final Color foregroundColor = Colors.black87;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor, // Button background color
        foregroundColor: foregroundColor, // Button text color
      ),
      child: Text(label),
    );
  }
}
