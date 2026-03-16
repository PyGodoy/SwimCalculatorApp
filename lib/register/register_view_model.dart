import 'package:flutter/material.dart';
import 'package:swimcalculator/services/auth.service.dart';

class RegisterViewModel extends ChangeNotifier {
  final _authService = AuthService();

  // controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // estados
  bool isLoading = false;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  String? errorMessage;

  // metodos
  void togglePassword() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  void toggleConfirmPassword() {
    obscureConfirmPassword = !obscureConfirmPassword;
    notifyListeners();
  }

  void limpaErro() {
    errorMessage = null;
    notifyListeners();
  }

  Future<void> register(BuildContext context) async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      errorMessage = 'Preencha todos os campos';
      notifyListeners();
      return;
    }

    if (password != confirmPassword) {
      errorMessage = 'As senhas não coincidem';
      notifyListeners();
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      await _authService.register(name, email, password);
      if (context.mounted) {
        Navigator.pushNamed(context, '/login');
      }
    } catch (e) {
      errorMessage = 'Erro ao criar conta. Tente novamente.';
    }

    isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}