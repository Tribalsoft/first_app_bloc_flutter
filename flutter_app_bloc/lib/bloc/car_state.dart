import 'package:equatable/equatable.dart';
import '../models/car.dart';

abstract class CarState extends Equatable {
  const CarState();

  @override
  List<Object?> get props => [];
}

class CarInitial extends CarState {}

class CarLoading extends CarState {}

class CarLoaded extends CarState {
  final Car car;

  const CarLoaded(this.car);

  @override
  List<Object?> get props => [car];
}

class CarError extends CarState {
  final String message;

  const CarError(this.message);

  @override
  List<Object?> get props => [message];
}
