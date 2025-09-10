/// Aplicación de demostración que implementa el patrón BLoC para gestionar
/// la autenticación de usuarios y visualización de datos de vehículos.
/// Utiliza Flutter BLoC para el manejo de estados y Material Design 3.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/auth_bloc.dart';
import 'bloc/car_bloc.dart';
import 'screens/login_screen.dart';

/// Punto de entrada principal de la aplicación
void main() {
  runApp(const MainApp());
}

/// Widget raíz de la aplicación que configura los providers de BLoC
/// y establece el tema general de la aplicación.
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Proveedor para la gestión de autenticación
        BlocProvider(create: (_) => AuthBloc()),
        // Proveedor para la gestión de datos del vehículo
        BlocProvider(create: (_) => CarBloc()),
      ],
      child: MaterialApp(
        title: 'Demo Flutter BLoC',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true, // Habilita Material Design 3
        ),
        home: const LoginScreen(), // Pantalla inicial de login
      ),
    );
  }
}
