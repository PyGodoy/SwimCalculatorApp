import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:swimcalculator/services/auth.service.dart';

class LoginViewModel extends ChangeNotifier{
  final _authService = AuthService();
  
  // controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  
  // estados
  bool isLoading = false;
  bool obscurePassword = true;
  String? errorMessage;
  
  // metodos
  void togglePassword() { 
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  void limpaErro() {                 
    errorMessage = null;
    notifyListeners();
  }

  Future<void>login(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      errorMessage = "Preencha o email e senha";
      notifyListeners();
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      await _authService.login(email, password);
      if (context.mounted) {
        Navigator.pushNamed(context, "/home");
        limpaErro();
      }
    } catch (e) {
      errorMessage = "Usuario e senha incorretos";
      notifyListeners();
      isLoading = false;
    }

    isLoading = false;
    notifyListeners();
  }
  // dipose
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}