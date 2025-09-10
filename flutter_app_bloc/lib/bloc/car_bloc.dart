import 'package:flutter_bloc/flutter_bloc.dart';
import 'car_event.dart';
import 'car_state.dart';
import '../models/car.dart';

class CarBloc extends Bloc<CarEvent, CarState> {
  CarBloc() : super(CarInitial()) {
    on<LoadCarDetails>(_onLoadCarDetails);
  }

  Future<void> _onLoadCarDetails(
    LoadCarDetails event,
    Emitter<CarState> emit,
  ) async {
    emit(CarLoading());
    
    try {
      // Simulate API call with hardcoded data
      await Future.delayed(const Duration(seconds: 1));
      
      final carData = {
        'brand': 'Tesla',
        'model': 'Model S',
        'year': 2023,
      };
      
      final car = Car.fromJson(carData);
      emit(CarLoaded(car));
    } catch (e) {
      emit(CarError('Error al cargar los detalles del vehículo'));
    }
  }
}
