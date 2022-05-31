import 'package:flutter/material.dart';
import 'package:todolist_app/models/onboarding_content.dart';
import 'package:todolist_app/screens/introduction_screen.dart';
import 'package:todolist_app/theme/colors.dart';
import 'package:todolist_app/widgets/general/custom_text_button.dart';
import 'package:todolist_app/widgets/onboarding_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  final pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: mediaQuery.size.height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  onboardingContentList.length,
                  (index) => builDot(context, index),
                ),
              ),
              Expanded(
                child: PageView.builder(
                    controller: pageController,
                    onPageChanged: (index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    itemCount: onboardingContentList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Expanded(
                              child: Image.asset(
                            onboardingContentList[index].imagePath,
                          )),
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              color: primaryColor,
                              height: mediaQuery.size.height * 0.4,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: mediaQuery.size.height * 0.08,
                                  ),
                                  Text(
                                    onboardingContentList[index].content,
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: mediaQuery.size.height * 0.11,
                                  ),
                                  index == onboardingContentList.length - 1
                                      ? Onboardingbutton(
                                          text: 'Get Started',
                                          currentIndex: currentIndex,
                                          pageController: pageController)
                                      : Onboardingbutton(
                                          currentIndex: currentIndex,
                                          pageController: pageController,
                                          text: 'Continue',
                                        ),
                                  currentIndex !=
                                          onboardingContentList.length - 1
                                      ? CustomTextButton(
                                          textColor: Colors.white,
                                          text: 'Skip',
                                          function: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const IntroductionScreen()));
                                          },
                                        )
                                      : const SizedBox(
                                          height: 1,
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget builDot(BuildContext context, int index) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: currentIndex == index ? primaryColor : Colors.grey,
      height: 5,
      width: 90,
    );
  }
}
