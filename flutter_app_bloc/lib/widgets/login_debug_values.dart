import 'package:flutter/material.dart';

class LoginDebugValues extends StatelessWidget {
  final String username;
  final String password;

  const LoginDebugValues({
    super.key,
    required this.username,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Debug - Usuario: $username',
          style: const TextStyle(color: Colors.grey),
        ),
        Text(
          'Debug - Contraseña: $password',
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
