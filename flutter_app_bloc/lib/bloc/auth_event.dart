/// Este archivo define los eventos relacionados con la autenticación
/// que pueden ser manejados por el AuthBloc.

import 'package:equatable/equatable.dart';

/// Clase base abstracta para todos los eventos de autenticación.
/// Extiende de Equatable para permitir comparaciones de igualdad basadas en valor.
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Evento que se dispara cuando el usuario intenta iniciar sesión.
/// Contiene las credenciales ingresadas por el usuario.
class LoginSubmitted extends AuthEvent {
  /// Nombre de usuario ingresado
  final String username;
  /// Contraseña ingresada
  final String password;

  const LoginSubmitted({
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [username, password]; // Para comparación de eventos
}
