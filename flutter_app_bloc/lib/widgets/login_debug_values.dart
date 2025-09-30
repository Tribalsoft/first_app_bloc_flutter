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
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '🔧 Información de prueba:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Emails válidos: Sincere@april.biz, Julianne.OConner@kory.org',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const Text(
            'Contraseña: password123',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Text(
            'Usuario actual: $username',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          Text(
            'Contraseña actual: $password',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
