import 'package:flutter_bloc/flutter_bloc.dart';
import 'car_event.dart';
import 'car_state.dart';
import '../services/car_api_service.dart';

class CarBloc extends Bloc<CarEvent, CarState> {
  final CarApiService _carService;

  CarBloc({CarApiService? carService})
    : _carService = carService ?? CarApiService(),
      super(CarInitial()) {
    on<LoadCarDetails>(
      _onLoadCarDetails,
      transformer: (events, mapper) => events
          .distinct() // Evita eventos duplicados
          .asyncExpand(mapper)
          .takeWhile((_) => !isClosed), // Evita emisiones después del cierre
    );

    on<LoadAllCars>(
      _onLoadAllCars,
      transformer: (events, mapper) =>
          events.distinct().asyncExpand(mapper).takeWhile((_) => !isClosed),
    );
  }

  Future<void> _onLoadCarDetails(
    LoadCarDetails event,
    Emitter<CarState> emit,
  ) async {
    if (isClosed) return;
    emit(CarLoading());

    try {
      final car = await _carService.getCarDetails(event.carId);
      if (!isClosed) {
        emit(CarLoaded(car));
      }
    } catch (e) {
      if (!isClosed) {
        emit(CarError(e.toString()));
      }
    }
  }

  Future<void> _onLoadAllCars(LoadAllCars event, Emitter<CarState> emit) async {
    if (isClosed) return;
    emit(CarLoading());

    try {
      final cars = await _carService.getAllCars();
      if (!isClosed) {
        emit(CarsLoaded(cars));
      }
    } catch (e) {
      if (!isClosed) {
        emit(CarError(e.toString()));
      }
    }
  }

  @override
  Future<void> close() {
    _carService.dispose();
    return super.close();
  }
}
