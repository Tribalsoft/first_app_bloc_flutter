import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/car_bloc.dart';
import '../bloc/car_state.dart';
import '../models/car.dart';

class CarDetailsWidget extends StatelessWidget {
  const CarDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarBloc, CarState>(
      buildWhen: (previous, current) {
        // Solo reconstruir en los siguientes casos:
        // 1. Cambio de Loading a cualquier otro estado
        // 2. Cambio de cualquier estado a Loading
        // 3. Cambio de Error a Loaded
        // 4. Primera carga de datos (Initial a cualquier estado)
        if (previous is CarLoading != current is CarLoading) return true;
        if (previous is CarError && current is CarLoaded) return true;
        if (previous is CarInitial) return true;
        return false;
      },
      builder: (context, state) {
        if (state is CarLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CarLoaded) {
          return _buildCarDetails(state.car);
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
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildCarDetails(Car car) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Brand: ${car.brand}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Model: ${car.model}',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 8),
          Text(
            'Year: ${car.year}',
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
