import 'package:equatable/equatable.dart';
import '../models/user.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

/// Estado inicial antes de cualquier intento de carga de usuarios.
/// Se usa cuando la pantalla se muestra por primera vez.
class UserInitial extends UserState {}

/// Estado que indica que se están cargando los usuarios desde la API.
/// Durante este estado se muestra un indicador de carga.
class UserLoading extends UserState {}

/// Estado que indica que los usuarios se cargaron exitosamente.
/// Contiene la lista de usuarios obtenida de la API.
class UsersLoaded extends UserState {
  /// Lista de usuarios cargados desde la API
  final List<User> users;

  const UsersLoaded(this.users);

  @override
  List<Object?> get props => [users];
}

/// Estado que indica que ocurrió un error durante la carga de usuarios.
/// Contiene un mensaje de error para mostrar al usuario.
class UserError extends UserState {
  /// Mensaje descriptivo del error ocurrido
  final String message;

  const UserError(this.message);

  @override
  List<Object?> get props => [message]; // Para comparación de estados
}
