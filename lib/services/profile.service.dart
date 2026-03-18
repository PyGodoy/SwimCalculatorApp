import 'package:dio/dio.dart';
import 'package:swimcalculator/services/auth.service.dart';

class ProfileService {
  final Dio _dio = Dio();
  final String baseUrl = 'http://192.168.68.106:7000/api';
  final AuthService _authService = AuthService();
  
  Future<dynamic>getProfile() async {
    try {
      final token = await _authService.getToken();
      final response = await _dio.get(
        '$baseUrl/profile',
        options: Options(
          headers: {'Authorization': 'Bearer $token'}
        )
      );
      return response.data;
      } catch (e) {
      throw Exception("Erro ao buscar perfil");
    }
  }

  Future<dynamic>putProfile(String name, String email) async {
    try {
      final token = await _authService.getToken();
      final response = await _dio.put(
        '$baseUrl/profile/edit',
        data: {
          'name':name,
          'email':email,
        },
        options: Options(
          headers: {'Authorization': 'Bearer $token'}
        )
      );
      return response.data;
    } catch (e) {
      throw Exception("Erro ao editar perfil");
    }
  }
}