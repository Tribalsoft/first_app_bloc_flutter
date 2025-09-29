import 'package:equatable/equatable.dart';
import '../models/car.dart';

abstract class CarState extends Equatable {
  const CarState();

  @override
  List<Object?> get props => [];
}

/// Estado inicial antes de cargar los datos del vehículo
class CarInitial extends CarState {}

/// Estado que indica que se están cargando los datos
class CarLoading extends CarState {}

/// Estado que indica que los datos de un vehículo específico se cargaron exitosamente
class CarLoaded extends CarState {
  final Car car;

  const CarLoaded(this.car);

  @override
  List<Object?> get props => [car];
}

/// Estado que indica que la lista de todos los vehículos se cargó exitosamente
class CarsLoaded extends CarState {
  final List<Car> cars;

  const CarsLoaded(this.cars);

  @override
  List<Object?> get props => [cars];
}

/// Estado que indica que ocurrió un error
class CarError extends CarState {
  final String message;

  const CarError(this.message);

  @override
  List<Object?> get props => [message];
}
