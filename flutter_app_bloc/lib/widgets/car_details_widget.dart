import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/car_bloc.dart';
import '../bloc/car_state.dart';
import '../bloc/car_event.dart';
import '../models/car.dart';

class CarDetailsWidget extends StatelessWidget {
  const CarDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarBloc, CarState>(
      builder: (context, state) {
        if (state is CarLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CarsLoaded) {
          return _buildCarList(state.cars);
        } else if (state is CarLoaded) {
          return _buildCarDetail(state.car);
        } else if (state is CarError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 48),
                const SizedBox(height: 16),
                Text(state.message),
              ],
            ),
          );
        }
        return const Center(child: Text('Selecciona un vehículo'));
      },
    );
  }

  Widget _buildCarList(List<Car> cars) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: cars.length,
      itemBuilder: (context, index) {
        final car = cars[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: ListTile(
            title: Text(
              car.brand,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('${car.model} (${car.year})'),
            onTap: () {
              // Cargar detalles específicos del carro
              context.read<CarBloc>().add(LoadCarDetails(car.id));
            },
          ),
        );
      },
    );
  }

  Widget _buildCarDetail(Car car) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            car.brand,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text('Modelo: ${car.model}', style: const TextStyle(fontSize: 18)),
          Text('Año: ${car.year}', style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
