/// Define los eventos relacionados con la carga y gestión de datos
/// del vehículo que pueden ser manejados por el CarBloc.

import 'package:equatable/equatable.dart';

/// Clase base abstracta para todos los eventos relacionados con el vehículo.
/// Extiende de Equatable para permitir comparaciones de igualdad basadas en valor.
abstract class CarEvent extends Equatable {
  const CarEvent();

  @override
  List<Object?> get props => [];
}

/// Evento que solicita la carga de los detalles del vehículo.
/// Se dispara cuando se accede a la pantalla principal.
class LoadCarDetails extends CarEvent {}
