/// Widget que implementa el botón de inicio de sesión con manejo de estados
/// y feedback visual durante el proceso de autenticación.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';
import '../bloc/auth_event.dart';

/// Widget que maneja la interacción del botón de login y su estado visual.
class LoginButton extends StatelessWidget {
  /// Usuario ingresado que se enviará en el evento de login
  final String username;
  
  /// Contraseña ingresada que se enviará en el evento de login
  final String password;

  const LoginButton({
    super.key,
    required this.username,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      // Solo reconstruye el widget cuando cambia el estado de loading
      buildWhen: (previous, current) =>
          previous is AuthLoading != current is AuthLoading,
      builder: (context, state) {
        // Muestra un indicador de carga durante la autenticación
        if (state is AuthLoading) {
          return const CircularProgressIndicator();
        }
        // Muestra el botón de acceso en estado normal
        return ElevatedButton(
          onPressed: () {
            // Dispara el evento de login con las credenciales
            context.read<AuthBloc>().add(
                  LoginSubmitted(
                    username: username,
                    password: password,
                  ),
                );
          },
          child: const Text('Acceder'),
        );
      },
    );
  }
}
