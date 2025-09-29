import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  bool _mounted = true;

  @override
  Future<void> close() {
    _mounted = false;
    return super.close();
  }

  Future<void> login(String username, String password) async {
    // Evita emisiones duplicadas verificando el estado actual
    if (state is AuthLoading) return;

    emit(AuthLoading());

    try {
      await Future.delayed(const Duration(seconds: 2));

      if (!_mounted) return; // Evita emisiones si el cubit está cerrado

      if (username == 'error') {
        emit(const AuthError('Credenciales inválidas'));
      } else {
        final currentState = state;
        if (currentState is! AuthSuccess) {
          // Evita emisiones duplicadas
          emit(AuthSuccess());
        }
      }
    } catch (e) {
      if (_mounted) {
        emit(const AuthError('Error inesperado durante el login'));
      }
    }
  }
}
