import 'package:flutter/material.dart';
import 'package:swimcalculator/services/profile.service.dart';

class EditprofileViewModel extends ChangeNotifier{
  // controllers
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final ProfileService _profileService = ProfileService();
  // estados  
  bool isLoading = false;
  String? errorMessage;
  // metodos
  Future<void>carregarPerfil() async {
    try {
      isLoading = true;
      notifyListeners();
      final dados = await _profileService.getProfile();
      name.text = dados['name'];
      email.text = dados['email'];
    } catch (e) {
      errorMessage = 'Erro ao carregar perfil';
      notifyListeners();
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> salvarPerfil(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();

      await _profileService.putProfile(name.text, email.text);
      
      if (context.mounted) {
        Navigator.pop(context); // volta para o perfil
      }

    } catch (e) {
      errorMessage = 'Erro ao salvar perfil';
      notifyListeners();
    }
    isLoading = false;
    notifyListeners();
  }
  //dispose
}