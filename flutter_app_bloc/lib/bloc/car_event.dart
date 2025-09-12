import 'package:equatable/equatable.dart';

abstract class CarEvent extends Equatable {
  const CarEvent();

  @override
  List<Object?> get props => [];
}

/// Evento que solicita la carga de los detalles del vehículo.
/// Se dispara cuando se accede a la pantalla principal.
class LoadCarDetails extends CarEvent {}
