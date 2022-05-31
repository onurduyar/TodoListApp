import 'package:flutter/material.dart';
import 'package:todolist_app/screens/login_screen.dart';
import 'package:todolist_app/widgets/form/form_page.dart';
import 'package:todolist_app/widgets/general/custom_text_button.dart';
import 'package:todolist_app/widgets/general/my_custom_clipper.dart';
import 'package:todolist_app/widgets/general/title_container.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: mediaQuery.size.height -
                    (mediaQuery.padding.top + kToolbarHeight)),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  ClipPath(
                    clipper: MycustomClipper(),
                    child: const TitleContainer(value: 0.3),
                  ),
                  const FormPage(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already using Todo-List app?'),
                      CustomTextButton(
                          text: 'Log in ',
                          textColor: Theme.of(context).primaryColor,
                          function: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                          }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
