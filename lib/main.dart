import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Importar o provider
import 'package:swimcalculator/swimcalculatoapp.dart';
void main() {
  runApp(SwimCalculatorApp());
}

class SwimCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue, // Define a cor primária como azul
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue, // AppBar azul
          titleTextStyle: TextStyle(
            color: Colors.white, // Título branco no AppBar
            fontSize: 20,
          ),
        ),
      ),
      home: SwimCalculatorPage(),
    );
  }
}