import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'profile_page.dart';
import 'help_page.dart';
import 'saves_page.dart';

class SwimCalculatorPage extends StatefulWidget {
  @override
  _SwimCalculatorPageState createState() => _SwimCalculatorPageState();
}

class _SwimCalculatorPageState extends State<SwimCalculatorPage> {
  final TextEditingController hoursController = TextEditingController();
  final TextEditingController minutesController = TextEditingController();
  final TextEditingController secondsController = TextEditingController();
  final TextEditingController distanceController = TextEditingController();

  String paceMinutes = '--';
  String paceSeconds = '--';
  String speed = '--';
  bool canSave = false;

  List<Map<String, String>> savedData = [];

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  void _loadSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? data = prefs.getStringList('savedData');
    if (data != null) {
      setState(() {
        savedData = data.map((item) {
          final parts = item.split('|');
          return {
            'title': parts[0],
            'distance': parts[1],
            'time': parts[2],
            'pace': parts[3],
            'speed': parts[4],
          };
        }).toList();
      });
    }
  }

  void _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> data = savedData.map((item) {
      return '${item['title']}|${item['distance']}|${item['time']}|${item['pace']}|${item['speed']}';
    }).toList();
    await prefs.setStringList('savedData', data);
  }
}