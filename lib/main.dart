import 'package:flutter/material.dart';
import 'package:swimcalculator/home/home_view.dart';
import 'package:swimcalculator/login/login_view.dart';
import 'package:swimcalculator/register/register_view.dart';

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
        primaryColor: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
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
        '/home': (context) => SwimCalculatorPage(),
      },
    );
  }
}