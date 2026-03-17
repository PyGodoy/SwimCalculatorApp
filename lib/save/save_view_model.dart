import 'package:flutter/material.dart';
import 'package:swimcalculator/services/activity.service.dart';

class SaveViewModel extends ChangeNotifier{

  final _activityService = ActivityService();
  bool isLoading = false;
  String? errorMessage;
  List<dynamic> saves = [];
  
  Future<void>getSaves() async {

    isLoading = true;
    notifyListeners();

    try {
      final dados = await _activityService.getSaves();
      saves = dados;
    } catch (e) {
      errorMessage = "Erro ao carregar dados";
    }
    isLoading = false;
    notifyListeners();
  }
  
  Future<void> deleteSave(int id) async {
    try {
      await _activityService.deleteSaves(id);
      saves.removeWhere((save) => save['id'] == id);
      notifyListeners();
    } catch (e) {
      errorMessage = 'Erro ao deletar save';
      notifyListeners();
    }
  }
  //dispose
  @override
  void dispose() {
    super.dispose();
  }
}