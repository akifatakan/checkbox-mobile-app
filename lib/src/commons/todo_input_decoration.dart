import 'package:flutter/material.dart';

class TodoInputDecoration {
  static InputDecoration getDecoration({required String labelText}) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(color: Colors.grey[800]), // Darker text for better contrast
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.grey[400]!), // Darker border for enabled state
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.black), // Highlight color when field is focused
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.red), // Error state
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.red[700]!), // Focused error state
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      fillColor: Colors.white, // Background color of the field
      filled: true, // Enable the fillColor
    );
  }
}
