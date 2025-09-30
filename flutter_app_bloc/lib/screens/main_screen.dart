import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/user_bloc.dart';
import '../bloc/user_event.dart';
import '../widgets/user_list_widget.dart';
import '../widgets/car_image_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Cargar usuarios cuando se crea la pantalla
    context.read<UserBloc>().add(LoadUsers());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Principal'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          // Primera mitad: Imagen del carro
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: Card(
                elevation: 4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: const CarImageWidget(),
                ),
              ),
            ),
          ),
          // Separador visual
          Container(
            height: 2,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue.shade200,
                  Colors.blue.shade400,
                  Colors.blue.shade200,
                ],
              ),
            ),
          ),
          // Segunda mitad: Lista de usuarios
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.only(top: 8),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Lista de Usuarios',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ),
                  const Expanded(child: UserListWidget()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
