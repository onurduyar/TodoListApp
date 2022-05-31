import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist_app/models/onboarding_content.dart';
import 'package:todolist_app/screens/introduction_screen.dart';

import 'general/my_custom_button.dart';

class Onboardingbutton extends StatelessWidget {
  const Onboardingbutton(
      {required this.text,
      required this.currentIndex,
      required this.pageController,
      Key? key})
      : super(key: key);
  final String text;
  final PageController pageController;
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    return MyCustomButton(
      textColor: Theme.of(context).primaryColor,
      text: text,
      upContext: context,
      function: () {
        if (currentIndex == onboardingContentList.length - 1) {
          _storeOnboardInfo();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const IntroductionScreen(),
            ),
          );
        }
        pageController.nextPage(
            duration: const Duration(milliseconds: 100),
            curve: Curves.bounceIn);
      },
      color: Colors.white,
    );
  }

  _storeOnboardInfo() async {
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
  }
}
