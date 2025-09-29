import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// Estado inicial antes de cualquier intento de autenticación.
/// Se usa cuando la pantalla de login se muestra por primera vez.
class AuthInitial extends AuthState {}

/// Estado que indica que se está procesando la autenticación.
/// Durante este estado se muestra un indicador de carga.
class AuthLoading extends AuthState {}

/// Estado que indica que la autenticación fue exitosa.
/// Desencadena la navegación a la pantalla principal.
class AuthSuccess extends AuthState {}

/// Estado que indica que ocurrió un error durante la autenticación.
/// Contiene un mensaje de error para mostrar al usuario.
class AuthError extends AuthState {
  /// Mensaje descriptivo del error ocurrido
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message]; // Para comparación de estados
}
