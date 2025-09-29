import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/car.dart';

class CarApiService {
  final http.Client _client;

  CarApiService({http.Client? client}) : _client = client ?? http.Client();

  Future<Car> getCarDetails(String id) async {
    try {
      final response = await _client
          .get(
            Uri.parse('${ApiConfig.baseUrl}${ApiConfig.carsEndpoint}/$id'),
            headers: ApiConfig.headers,
          )
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () => throw Exception('Tiempo de espera agotado'),
          );

      if (response.statusCode == 200) {
        return Car.fromJson(json.decode(response.body));
      } else {
        throw Exception(
          'Error ${response.statusCode}: ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      throw Exception('Error al obtener detalles del vehículo: $e');
    }
  }

  Future<List<Car>> getAllCars() async {
    try {
      final response = await _client
          .get(
            Uri.parse('${ApiConfig.baseUrl}${ApiConfig.carsEndpoint}'),
            headers: ApiConfig.headers,
          )
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () => throw Exception('Tiempo de espera agotado'),
          );

      if (response.statusCode == 200) {
        final List<dynamic> carsJson = json.decode(response.body);
        return carsJson.map((json) => Car.fromJson(json)).toList();
      } else {
        throw Exception(
          'Error ${response.statusCode}: ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      throw Exception('Error al obtener lista de vehículos: $e');
    }
  }

  // Método para liberar recursos
  void dispose() {
    _client.close();
  }
}
