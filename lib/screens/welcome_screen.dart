import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:todolist_app/widgets/general/my_custom_button.dart';
import 'package:todolist_app/widgets/general/my_custom_clipper.dart';

import '../theme/colors.dart';
import 'home_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  final String username = 'Adam';
  final String content =
      'Reach your goals faster and keep your personal or proffesional life in order.';
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          ClipPath(
            clipper: MycustomClipper(),
            child: Container(
              width: double.infinity,
              height: mediaQuery.size.height * 0.55,
              color: primaryColor,
              child: Column(
                children: [
                  SizedBox(
                    height: mediaQuery.size.height * 0.15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/tick.svg',
                        color: Colors.white,
                        height: 30,
                        width: 30,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Todo-List',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: mediaQuery.size.height * 0.11,
                  ),
                  Text(
                    'Welcome aboard,',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    '$username!',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: mediaQuery.size.height * 0.08,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              content,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(
            height: mediaQuery.size.height * 0.08,
          ),
          MyCustomButton(
              textColor: Colors.white,
              color: Theme.of(context).primaryColor,
              text: 'GetStarted',
              upContext: context,
              function: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              }),
        ],
      ),
    ));
  }
}
