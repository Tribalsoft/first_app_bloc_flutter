import 'package:equatable/equatable.dart';

class Car extends Equatable {
  final String brand;
  final String model;
  final int year;

  const Car({
    required this.brand,
    required this.model,
    required this.year,
  });

  @override
  List<Object?> get props => [brand, model, year];

  static Car fromJson(Map<String, dynamic> json) {
    return Car(
      brand: json['brand'] as String,
      model: json['model'] as String,
      year: json['year'] as int,
    );
  }
}
