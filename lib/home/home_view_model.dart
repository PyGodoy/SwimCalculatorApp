import 'package:flutter/material.dart';
import 'package:swimcalculator/services/activity.service.dart';

class HomeViewModel extends ChangeNotifier{
  final ActivityService _activityService = ActivityService();
  // controllers
  final TextEditingController hoursController = TextEditingController();
  final TextEditingController minutesController = TextEditingController();
  final TextEditingController secondsController = TextEditingController();
  final TextEditingController distanceController = TextEditingController();

  String paceMinutes = '--';
  String paceSeconds = '--';
  String speed = '--';
  bool canSave = false;
  String? errorMessage;

  // metods
  void calculate() {
    int hours = int.tryParse(hoursController.text) ?? 0;
    int minutes = int.tryParse(minutesController.text) ?? 0;
    int seconds = int.tryParse(secondsController.text) ?? 0;
    double distance = double.tryParse(distanceController.text) ?? 0;

    int totalSeconds = hours * 3600 + minutes * 60 + seconds;

    if (totalSeconds > 0 && distance > 0) {
      double pacePer100m = totalSeconds / (distance * 10);
      int paceMin = (pacePer100m / 60).floor();
      int paceSec = (pacePer100m % 60).floor();

      double speedKmPerHr = distance / (totalSeconds / 3600);

      paceMinutes = paceMin.toString().padLeft(2,'0');
      paceSeconds = paceSec.toString().padLeft(2,'0');
      speed = speedKmPerHr.toStringAsFixed(2);
      canSave = true;
    } else {
      paceMinutes = '--';
      paceSeconds = '--';
      speed = '--';
      canSave = false;
    }
    notifyListeners();
  }

  Future<void>saveActivity(String title) async {
    try {
      await _activityService.postSaves(
        title,
        distanceController.text,
        '${hoursController.text}:${minutesController.text}:${secondsController.text}',
        '$paceMinutes:$paceSeconds',
        speed,
      );
      hoursController.clear();
      minutesController.clear();
      secondsController.clear();
      distanceController.clear();
      paceMinutes = '--';
      paceSeconds = '--';
      speed = '--';
      canSave = false;
      notifyListeners();
    } catch (e) {
      errorMessage = "Erro ao salvar dados";
      notifyListeners();
    }
  }
  // dispose
  @override
  void dispose() {
    hoursController.dispose();
    minutesController.dispose();
    secondsController.dispose();
    distanceController.dispose();
    super.dispose();
  }
}