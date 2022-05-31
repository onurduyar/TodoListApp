import 'package:flutter/material.dart';

class MyInputTheme {
  TextStyle _buildTextStyle(Color color, {double size = 16.0}) {
    return TextStyle(
      color: color,
      fontSize: size,
    );
  }

  OutlineInputBorder _buildBorder(Color color) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(
          color: color,
          width: 1,
        ));
  }

  InputDecorationTheme theme() {
    return InputDecorationTheme(
      focusedErrorBorder: _buildBorder(Colors.red.shade900),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      contentPadding: const EdgeInsets.all(16),
      errorBorder: _buildBorder(Colors.black),
      enabledBorder: _buildBorder(Colors.black),
      disabledBorder: _buildBorder(Colors.black),
      focusedBorder: _buildBorder(Colors.black),
      floatingLabelStyle: _buildTextStyle(Colors.red),
    );
  }
}
