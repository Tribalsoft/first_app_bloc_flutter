import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import 'animated_loading_widget.dart';

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
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Theme.of(context).primaryColor.withOpacity(0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PulsingLoadingWidget(
                  duration: const Duration(milliseconds: 1800),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Iniciando sesión...',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 2),
                    DotsLoadingWidget(
                      color: Theme.of(context).primaryColor,
                      size: 4,
                      duration: const Duration(milliseconds: 1000),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
        // Muestra el botón de acceso en estado normal
        return ElevatedButton(
          onPressed: username.isNotEmpty && password.isNotEmpty
              ? () {
                  // Dispara el evento de login con las credenciales
                  context.read<AuthCubit>().login(username, password);
                }
              : null, // Deshabilita el botón si faltan credenciales
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Acceder',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      },
    );
  }
}
