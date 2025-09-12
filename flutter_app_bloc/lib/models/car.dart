import 'package:equatable/equatable.dart';

class Car extends Equatable {
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
