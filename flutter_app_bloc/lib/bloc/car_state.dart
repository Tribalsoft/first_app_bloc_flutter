/// Define los diferentes estados posibles durante la carga y visualización
/// de los datos del vehículo. Cada estado representa una situación específica
/// en el proceso de obtención y muestra de datos.

import 'package:equatable/equatable.dart';
import '../models/car.dart';

/// Clase base abstracta para todos los estados relacionados con el vehículo.
/// Implementa Equatable para comparaciones de estado basadas en valor.
abstract class CarState extends Equatable {
  const CarState();

  @override
  List<Object?> get props => [];
}

/// Estado inicial antes de cargar los datos del vehículo.
/// Se muestra cuando se accede por primera vez a la pantalla principal.
class CarInitial extends CarState {}

/// Estado que indica que se están cargando los datos del vehículo.
/// Durante este estado se muestra un indicador de carga.
class CarLoading extends CarState {}

/// Estado que indica que los datos del vehículo se cargaron exitosamente.
/// Contiene la información del vehículo para mostrar en la UI.
class CarLoaded extends CarState {
  /// Objeto Car con los datos del vehículo
  final Car car;

  const CarLoaded(this.car);

  @override
  List<Object?> get props => [car];
}

/// Estado que indica que ocurrió un error al cargar los datos del vehículo.
/// Contiene un mensaje de error para mostrar al usuario.
class CarError extends CarState {
  /// Mensaje descriptivo del error ocurrido
  final String message;

  const CarError(this.message);

  @override
  List<Object?> get props => [message];
}
