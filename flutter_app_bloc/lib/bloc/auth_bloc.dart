/// Implementa la lógica de negocio para el proceso de autenticación.
/// Maneja los eventos de login y emite los estados correspondientes.

import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

/// BLoC que gestiona el proceso de autenticación.
/// Recibe eventos de tipo AuthEvent y emite estados de tipo AuthState.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  /// Constructor que inicializa el estado como AuthInitial y
  /// registra los manejadores de eventos.
  AuthBloc() : super(AuthInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  /// Maneja el evento de envío de credenciales de login.
  /// 
  /// Parámetros:
  /// - event: Contiene el usuario y contraseña ingresados
  /// - emit: Función para emitir nuevos estados
  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    // Indica que se está procesando la autenticación
    emit(AuthLoading());
    
    // Simula un retraso de red de 2 segundos
    await Future.delayed(const Duration(seconds: 2));

    // Lógica simple de validación:
    // Si el usuario es 'error', simula un error de autenticación
    // Cualquier otro valor se considera válido
    if (event.username == 'error') {
      emit(const AuthError('Credenciales inválidas'));
    } else {
      emit(AuthSuccess());
    }
  }
}
