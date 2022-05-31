import 'package:flutter/material.dart';

class ConfirmPwdField extends StatefulWidget {
  const ConfirmPwdField({Key? key}) : super(key: key);

  @override
  State<ConfirmPwdField> createState() => _ConfirmPwdFieldState();
}

class _ConfirmPwdFieldState extends State<ConfirmPwdField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Confirm Password'),
    );
  }
}
