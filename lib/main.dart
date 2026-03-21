import 'package:flutter/material.dart';
import 'package:swimcalculator/help/help_view.dart';
import 'package:swimcalculator/home/home_view.dart';
import 'package:swimcalculator/login/login_view.dart';
import 'package:swimcalculator/profile/editProfile/editprofile_view.dart';
import 'package:swimcalculator/profile/profile_view.dart';
import 'package:swimcalculator/register/register_view.dart';
import 'package:swimcalculator/save/save_view.dart';

void main() {
  runApp(const SwimCalculatorApp());
}

class SwimCalculatorApp extends StatelessWidget {
  const SwimCalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFF1A6BFF)
        ),
        primaryColor: Color(0xFF1A6BFF),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1A6BFF),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginView(),
        '/register': (context) => const RegisterView(),
        '/home': (context) => const HomeView(),
        '/save': (context) => const SaveView(),
        '/help': (context) => const HelpView(),
        '/profile': (context) => const ProfileView(),
        '/edit-profile': (context) => EditprofileView(),
      },
    );
  }
}