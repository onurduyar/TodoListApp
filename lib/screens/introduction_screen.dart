import 'package:flutter/material.dart';
import 'package:todolist_app/screens/signup_screen.dart';
import 'package:todolist_app/widgets/general/custom_text_button.dart';
import 'package:todolist_app/widgets/general/my_custom_button.dart';
import 'package:todolist_app/widgets/general/my_custom_clipper.dart';
import 'package:todolist_app/widgets/general/title_container.dart';

import 'login_screen.dart';

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          ClipPath(
            clipper: MycustomClipper(),
            child: const TitleContainer(value: 0.67),
          ),
          SizedBox(
            height: mediaQuery.size.height * 0.07,
          ),
          MyCustomButton(
              textColor: Colors.white,
              color: Theme.of(context).primaryColor,
              text: 'Sign Up',
              upContext: context,
              function: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignUpPage()));
              }),
          CustomTextButton(
            text: 'Log in',
            textColor: Theme.of(context).primaryColor,
            function: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
          ),
        ],
      )),
    );
  }
}
