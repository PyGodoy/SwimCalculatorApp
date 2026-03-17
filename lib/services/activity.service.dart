import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swimcalculator/services/auth.service.dart';

class ActivityService {
  final Dio _dio = Dio();
  final String baseUrl = 'http://192.168.68.106:7000/api';
  final AuthService _authService = AuthService();
  
  Future<dynamic>getSaves() async {
    try {
      final token = await _authService.getToken();
      final response = await _dio.get(
        '$baseUrl/activity/saves',
        options: Options(
          headers: {'Authorization': 'Bearer $token'}
        )
      );
      return response.data;
      } catch (e) {
      throw Exception("Erro ao buscar dados");
    }
  }

  Future<dynamic>postSaves(String title, String distance, String time, String pace, String speed) async {
    try {
      final token = await _authService.getToken();
      final response = await _dio.post(
        '$baseUrl/activity/saves',
        data: {
          'title' : title,
          'distance' : distance,
          'time' : time,
          'pace' : pace,
          'speed' : speed,
        },
        options: Options(
          headers: {'Authorization': 'Bearer $token'}
        )
      );
      return response.data;
    } catch (e) {
      print('erro detalhado: $e');
      throw Exception("Erro ao salvar dados");
    }
  }

  Future<dynamic>deleteSaves(id) async {
    try{
      final token = await _authService.getToken();
      final response = await _dio.delete(
        '$baseUrl/activity/saves/$id',
        options: Options(
          headers: {'Authorization': 'Bearer $token'}
        )
      );
      return response.data;
    } catch (e) {
      throw Exception("Erro ao deletar dados");
    }
  }

}