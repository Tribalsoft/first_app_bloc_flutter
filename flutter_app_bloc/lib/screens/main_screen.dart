import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/car_bloc.dart';
import '../bloc/car_event.dart';
import '../widgets/car_details_widget.dart';
import '../widgets/car_image_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Load car details when screen is created
    context.read<CarBloc>().add(
      LoadAllCars(),
    ); // Cargamos todos los carros inicialmente

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del Vehículo'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          // Top half - Car Image
          const Expanded(child: CarImageWidget()),
          // Bottom half - Car Details
          const Expanded(child: CarDetailsWidget()),
        ],
      ),
    );
  }
}
