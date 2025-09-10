/// Widget personalizado que representa un campo de texto para el formulario de login.
/// Proporciona una interfaz consistente para la entrada de usuario y contraseña.

import 'package:flutter/material.dart';

/// Widget que encapsula un TextField con estilo y comportamiento específico para login.
class LoginTextField extends StatelessWidget {
  /// Controlador para manejar el texto ingresado
  final TextEditingController controller;
  
  /// Etiqueta que se muestra sobre el campo de texto
  final String label;
  
  /// Indica si el campo debe ocultar el texto ingresado (para contraseñas)
  final bool isPassword;
  
  /// Callback que se ejecuta cada vez que cambia el texto
  final ValueChanged<String> onChanged;

  const LoginTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.onChanged,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      obscureText: isPassword, // Oculta el texto si es un campo de contraseña
      onChanged: onChanged, // Notifica cambios en el texto
    );
  }
}
