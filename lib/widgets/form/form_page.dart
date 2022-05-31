import 'package:flutter/material.dart';
import 'package:todolist_app/theme/colors.dart';
import '../../form_validation.dart';
import '../../screens/login_screen.dart';
import '../general/my_custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _passKey = GlobalKey<FormFieldState>();

  void signUp() async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
    } catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  String? validatePasswordMatching(String? value) {
    var pwd = _passKey.currentState!.value;
    if (value!.isEmpty) {
      return 'Password is required';
    } else if (value != pwd) {
      return 'Password is not matching';
    }
    return null;
  }

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        child: Column(
          children: [
            SizedBox(
              height: mediaQuery.size.height * 0.1,
              child: TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                validator: validateEmail,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: mediaQuery.size.height * 0.1,
              child: TextFormField(
                key: _passKey,
                obscureText: !_passwordVisible,
                controller: _passwordController,
                validator: validatePassword,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                        icon: _passwordVisible
                            ? const Icon(
                                Icons.visibility,
                                color: primaryColor,
                              )
                            : const Icon(
                                Icons.visibility_off,
                                color: primaryColor,
                              )),
                    labelText: 'Password'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: mediaQuery.size.height * 0.1,
              child: TextFormField(
                obscureText: !_confirmPasswordVisible,
                validator: validatePasswordMatching,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _confirmPasswordVisible = !_confirmPasswordVisible;
                        });
                      },
                      icon: _confirmPasswordVisible
                          ? const Icon(
                              Icons.visibility,
                              color: primaryColor,
                            )
                          : const Icon(
                              Icons.visibility_off,
                              color: primaryColor,
                            )),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            MyCustomButton(
                textColor: Colors.white,
                color: Theme.of(context).primaryColor,
                text: 'Create Account',
                upContext: context,
                function: () {
                  if (_formKey.currentState!.validate()) {
                    signUp();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  } else {
                    return;
                  }
                }),
          ],
        ),
      ),
    );
  }
}
