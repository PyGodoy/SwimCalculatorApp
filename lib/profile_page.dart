import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Page')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Developed by: Mikaell de Godoy Vitorio', style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text('Email: godoyvitorio99@gmail.com', style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text('App: Swim Calculator Pace', style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
