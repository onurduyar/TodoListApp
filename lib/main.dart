import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist_app/screens/introduction_screen.dart';
import 'package:todolist_app/screens/onboarding_screen.dart';
import 'package:todolist_app/theme/colors.dart';
import 'package:todolist_app/theme/my_input_theme.dart';
import 'package:firebase_core/firebase_core.dart';

int? isviewed;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isviewed = prefs.getInt('onBoard');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TodoList App',
      theme: ThemeData(
        inputDecorationTheme: MyInputTheme().theme(),
        primaryColor: primaryColor,
        textTheme: const TextTheme(
            headline6: TextStyle(color: Colors.white, fontSize: 24),
            headline5: TextStyle(color: Colors.white),
            headline3: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
      ),
      home:
          isviewed != 0 ? const OnboardingScreen() : const IntroductionScreen(),
    );
  }
}
