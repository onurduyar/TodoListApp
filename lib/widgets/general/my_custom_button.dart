import 'package:flutter/material.dart';

class MyCustomButton extends StatelessWidget {
  const MyCustomButton(
      {required this.text,
      required BuildContext upContext,
      required this.function,
      required this.color,
      required this.textColor,
      Key? key})
      : super(key: key);
  final VoidCallback function;
  final String text;
  final Color color;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return SizedBox(
      height: mediaQuery.size.height * 0.06,
      width: mediaQuery.size.width * 0.7,
      child: ElevatedButton(
        onPressed: function,
        child: Text(
          text,
          style: TextStyle(color: textColor),
        ),
        style: ElevatedButton.styleFrom(
          primary: color,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }
}
