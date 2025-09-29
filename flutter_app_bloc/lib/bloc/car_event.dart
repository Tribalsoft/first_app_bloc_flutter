import 'package:equatable/equatable.dart';

abstract class CarEvent extends Equatable {
  const CarEvent();

  @override
  List<Object?> get props => [];
}

/// Evento que solicita la carga de los detalles de un vehículo específico
class LoadCarDetails extends CarEvent {
  final String carId;

  const LoadCarDetails(this.carId);

  @override
  List<Object?> get props => [carId];
}

/// Evento que solicita la carga de todos los vehículos
class LoadAllCars extends CarEvent {}
