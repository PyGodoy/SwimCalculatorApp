import 'package:flutter/material.dart';
import 'package:swimcalculator/services/profile.service.dart';
import 'package:swimcalculator/shared/models/profile_model.dart';

class ProfileViewModel extends ChangeNotifier{

  final ProfileService _profileService = ProfileService();
  bool isLoading = false;
  String? errorMessage;
  ProfileModel? profile;

  Future<void> getProfile() async { 
    try {
      isLoading = true;
      notifyListeners();

      final dados = await _profileService.getProfile();
      profile = ProfileModel.fromJson(dados);

      isLoading = false;
      notifyListeners();
    } catch (e) {
      errorMessage = "Erro ao buscar perfil";
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> putProfile(String name, String email) async {
    try {
      isLoading = true;
      notifyListeners();

      final dados = await _profileService.putProfile(name, email);
      profile = ProfileModel.fromJson(dados);

      isLoading = false;
      notifyListeners();
    } catch (e) {
      errorMessage = 'Erro ao atualizar perfil';
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}