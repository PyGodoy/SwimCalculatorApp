
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final Dio _dio = Dio();
  final String baseUrl = 'https://swimpace-backend.vercel.app/api';


  Future<dynamic>register(String name, String email, String password) async {
    try {
      final response = await _dio.post(
        '$baseUrl/auth/register',
        data: {
          'name' : name,
          'email' : email,
          'password': password,
        }
      );
      return response.data;
    } catch (e) {
      throw Exception("Erro ao cadastrar usuário");
    }
  }

  Future<dynamic>login(String email, String password) async {
    try {
      final response = await _dio.post(
        '$baseUrl/auth/login',
        data: {
          'email' : email,
          'password': password,
        }
      );
      final token = response.data['token'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      print('TOKEN SALVO: $token');
      return response.data;
    } catch (e) {
      throw Exception("Erro ao realizar login");
    }
  }

  Future<void>loginWithGoogle(String name, String email) async {
    try {
      final response = await _dio.post(
        '$baseUrl/auth/google',
        data: {
          'name' : name,
          'email' : email
        },
      );
      final token = response.data['token'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
    } catch (e) {
      throw Exception("Erro ao logar com google");
    }
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

}