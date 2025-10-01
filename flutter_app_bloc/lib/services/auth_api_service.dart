import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/user.dart';

class AuthApiService {
  late final http.Client _client;

  AuthApiService() {
    _client = http.Client();
  }

  void dispose() {
    _client.close();
  }

  Future<User?> login(String email, String password) async {
    try {
      print('🔐 Intentando login con email: $email');
      
      // Agregar delay para simular proceso de autenticación más realista
      await Future.delayed(const Duration(seconds: 3, milliseconds: 500));
      
      // Simulamos autenticación usando el endpoint de usuarios
      // En un API real, esto sería un endpoint POST /auth/login
      final response = await _client.get(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.users}'),
        headers: ApiConfig.headers,
      ).timeout(const Duration(seconds: 10));

      print('📡 Respuesta del API: ${response.statusCode}');

      if (response.statusCode == 200) {
        final List<dynamic> usersData = json.decode(response.body);
        final users = usersData.map((json) => User.fromJson(json)).toList();
        
        print('👥 Usuarios obtenidos: ${users.length}');
        print('📧 Emails disponibles: ${users.map((u) => u.email).join(', ')}');
        
        // Simulamos validación de credenciales
        // En un API real, el servidor validaría las credenciales
        User? foundUser;
        try {
          foundUser = users.firstWhere(
            (user) => user.email.toLowerCase() == email.toLowerCase(),
          );
          print('✅ Usuario encontrado: ${foundUser.name} (${foundUser.email})');
        } catch (e) {
          print('❌ Usuario no encontrado para email: $email');
          throw Exception('Email no válido. Usa un email de la lista de usuarios disponibles.');
        }

        // Simulamos validación de password
        // En un API real, esto se haría en el servidor
        if (password == 'wil1122') {
          print('✅ Contraseña válida');
          return foundUser;
        } else {
          print('❌ Contraseña inválida: $password');
          throw Exception('Contraseña incorrecta. Usa: wil1122');
        }
      } else {
        throw Exception('Error del servidor: ${response.statusCode}');
      }
    } on SocketException {
      print('🌐 Error de conexión: Sin internet');
      throw Exception('No hay conexión a internet');
    } on http.ClientException {
      print('🔗 Error de cliente HTTP');
      throw Exception('Error de conexión');
    } catch (e) {
      print('💥 Error general: $e');
      if (e.toString().contains('Exception:')) {
        rethrow; // Re-lanza excepciones específicas
      }
      throw Exception('Error de autenticación: ${e.toString()}');
    }
  }

  Future<List<String>> getAvailableEmails() async {
    try {
      // Agregar delay para mostrar loading de emails
      await Future.delayed(const Duration(milliseconds: 1500));
      
      final response = await _client.get(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.users}'),
        headers: ApiConfig.headers,
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> usersData = json.decode(response.body);
        final users = usersData.map((json) => User.fromJson(json)).toList();
        return users.map((user) => user.email).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<bool> validateToken(String token) async {
    try {
      // Simulamos validación de token
      // En un API real, esto sería un endpoint para validar el JWT
      await Future.delayed(const Duration(milliseconds: 1000));
      return token.isNotEmpty && token.length > 10;
    } catch (e) {
      return false;
    }
  }
}