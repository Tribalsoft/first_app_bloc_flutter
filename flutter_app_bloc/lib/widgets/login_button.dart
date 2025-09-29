import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/auth_cubit.dart';
import '../bloc/auth_state.dart';

class LoginButton extends StatelessWidget {
  final String username;
  final String password;

  const LoginButton({
    super.key,
    required this.username,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
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
            context.read<AuthCubit>().login(username, password);
          },
          child: const Text('Acceder'),
        );
      },
    );
  }
}
