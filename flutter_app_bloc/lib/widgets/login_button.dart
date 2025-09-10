import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';
import '../bloc/auth_event.dart';

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
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, current) =>
          previous is AuthLoading != current is AuthLoading,
      builder: (context, state) {
        if (state is AuthLoading) {
          return const CircularProgressIndicator();
        }
        return ElevatedButton(
          onPressed: () {
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
