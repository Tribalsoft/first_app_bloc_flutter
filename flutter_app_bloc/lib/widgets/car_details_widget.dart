/// Widget que muestra los detalles del vehículo en la pantalla principal.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/car_bloc.dart';
import '../bloc/car_state.dart';
import '../models/car.dart';

/// Widget principal para mostrar la información detallada del vehículo.
/// Utiliza BlocBuilder para reaccionar a cambios en el estado de CarBloc.
class CarDetailsWidget extends StatelessWidget {
  const CarDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarBloc, CarState>(
      // Optimización de rendimiento: solo reconstruye el widget en casos específicos
      buildWhen: (previous, current) {
        // Reconstruir cuando:
        // 1. Cambia el estado de carga (loading/no-loading)
        if (previous is CarLoading != current is CarLoading) return true;
        // 2. Se recupera de un error y hay datos disponibles
        if (previous is CarError && current is CarLoaded) return true;
        // 3. Primera carga de datos
        if (previous is CarInitial) return true;
        return false;
      },
      builder: (context, state) {
        // Muestra indicador de carga
        if (state is CarLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        // Muestra los detalles del vehículo
        else if (state is CarLoaded) {
          return _buildCarDetails(state.car);
        }
        // Muestra mensaje de error con ícono
        else if (state is CarError) {
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
        // Estado inicial o desconocido
        return const SizedBox.shrink();
      },
    );
  }

  /// Construye la vista de detalles del vehículo con formato específico.
  /// Organiza la información en una columna con estilos consistentes.
  Widget _buildCarDetails(Car car) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Marca del vehículo con estilo destacado
          Text(
            'Marca: ${car.brand}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          // Modelo del vehículo
          Text(
            'Modelo: ${car.model}',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 8),
          // Año del vehículo
          Text(
            'Año: ${car.year}',
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
