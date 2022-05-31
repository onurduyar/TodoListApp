import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todolist_app/form_validation.dart';
import 'package:todolist_app/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:todolist_app/theme/colors.dart';
import '../widgets/general/my_custom_button.dart';
import '../widgets/general/my_custom_clipper.dart';
import '../widgets/general/title_container.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int success = 0;
  Future<void> signIn() async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      success = 0;
    } on FirebaseAuthException {
      success = 1;
    }
  }

  bool? _passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: mediaQuery.size.height -
                  (mediaQuery.padding.top + kToolbarHeight),
            ),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  ClipPath(
                    clipper: MycustomClipper(),
                    child: const TitleContainer(value: 0.3),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 60),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: mediaQuery.size.height * 0.1,
                              child: TextFormField(
                                controller: _emailController,
                                validator: validateEmail,
                                decoration:
                                    const InputDecoration(labelText: 'Email'),
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: mediaQuery.size.height * 0.1,
                              child: TextFormField(
                                obscureText: !_passwordVisible!,
                                controller: _passwordController,
                                validator: validatePassword,
                                decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _passwordVisible =
                                                !_passwordVisible!;
                                          });
                                        },
                                        icon: _passwordVisible!
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
                          ],
                        )),
                  ),
                  MyCustomButton(
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      text: 'Login',
                      upContext: context,
                      function: () async {
                        if (_formKey.currentState!.validate()) {
                          await signIn();
                          if (success != 1) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Login error')));
                          }
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
