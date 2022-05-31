import 'package:flutter/material.dart';
import '../../theme/colors.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton(
      {required this.text,
      required this.textColor,
      required this.function,
      Key? key})
      : super(key: key);
  final String text;
  final Color textColor;
  final VoidCallback function;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: function,
      child: Text(
        text,
        style: TextStyle(color: textColor),
      ),
      style: TextButton.styleFrom(
        primary: primaryColor,
      ),
    );
  }
}
