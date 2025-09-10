/// Modelo de datos que representa un vehículo en la aplicación.
/// Contiene la información básica de un automóvil como marca, modelo y año.

import 'package:equatable/equatable.dart';

/// Clase que define la estructura de datos de un vehículo.
/// Implementa Equatable para comparaciones basadas en valor.
class Car extends Equatable {
  /// Marca del vehículo (ej: Tesla, BMW, etc.)
  final String brand;
  
  /// Modelo específico del vehículo (ej: Model S, X5, etc.)
  final String model;
  
  /// Año de fabricación del vehículo
  final int year;

  /// Constructor que requiere todos los campos del vehículo
  const Car({
    required this.brand,
    required this.model,
    required this.year,
  });

  @override
  List<Object?> get props => [brand, model, year];

  /// Método de fábrica para crear una instancia de Car desde un Map.
  /// Útil para deserializar datos JSON de una API.
  static Car fromJson(Map<String, dynamic> json) {
    return Car(
      brand: json['brand'] as String,
      model: json['model'] as String,
      year: json['year'] as int,
    );
  }
}
