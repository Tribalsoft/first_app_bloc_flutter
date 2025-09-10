import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    if (event.username == 'error') {
      emit(const AuthError('Credenciales inválidas'));
    } else {
      emit(AuthSuccess());
    }
  }
}
