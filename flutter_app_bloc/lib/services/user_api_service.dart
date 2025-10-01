import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/user.dart';

class UserApiService {
  final http.Client _client;

  UserApiService({http.Client? client}) : _client = client ?? http.Client();

  Future<List<User>> getAllUsers() async {
    try {
      // Agregar delay para simular carga de datos desde servidor
      await Future.delayed(const Duration(seconds: 2, milliseconds: 500));
      
      final response = await _client
          .get(
            Uri.parse('${ApiConfig.baseUrl}${ApiConfig.users}'),
            headers: ApiConfig.headers,
          )
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () => throw Exception('Tiempo de espera agotado'),
          );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception(
          'Error ${response.statusCode}: ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      throw Exception('Error al obtener usuarios: $e');
    }
  }

  Future<User> getUserDetails(int id) async {
    try {
      // Agregar delay para simular carga de detalles de usuario
      await Future.delayed(const Duration(milliseconds: 1200));
      
      final response = await _client
          .get(
            Uri.parse('${ApiConfig.baseUrl}${ApiConfig.users}/$id'),
            headers: ApiConfig.headers,
          )
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () => throw Exception('Tiempo de espera agotado'),
          );

      if (response.statusCode == 200) {
        return User.fromJson(json.decode(response.body));
      } else {
        throw Exception(
          'Error ${response.statusCode}: ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      throw Exception('Error al obtener detalles del usuario: $e');
    }
  }

  void dispose() {
    _client.close();
  }
}
