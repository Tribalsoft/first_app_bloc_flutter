import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/auth_cubit.dart';
import 'bloc/user_bloc.dart';
import 'services/user_api_service.dart';
import 'services/auth_api_service.dart';
import 'screens/login_screen.dart';
// import 'widgets/app_loading_widget.dart'; // Para usar AppLoadingWidget si necesitas una pantalla de splash

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Creamos instancias únicas de los servicios
    final userService = UserApiService();
    final authService = AuthApiService();

    return MultiBlocProvider(
      providers: [
        // Proveedor para la gestión de autenticación usando Cubit
        BlocProvider(
          create: (_) => AuthCubit(authService),
          lazy: true, // Carga perezosa
        ),
        // Proveedor para la gestión de usuarios
        BlocProvider(
          create: (_) => UserBloc(userService),
          lazy: true, // Carga perezosa
        ),
      ],
      child: MaterialApp(
        title: 'Demo Flutter BLoC',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true, // Habilita Material Design 3
        ),
        home: const LoginScreen(), // Pantalla inicial de login
        
        // Para mostrar una pantalla de loading inicial, puedes usar:
        // home: FutureBuilder(
        //   future: _initializeApp(),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return const AppLoadingWidget(
        //         message: 'Cargando aplicación...',
        //       );
        //     }
        //     return const LoginScreen();
        //   },
        // ),
      ),
    );
  }
}
