import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/auth_bloc.dart';
import 'bloc/car_bloc.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const MainApp());
}

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
