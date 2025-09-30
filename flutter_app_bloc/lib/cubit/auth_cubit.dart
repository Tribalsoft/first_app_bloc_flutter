import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';
import '../services/auth_api_service.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthApiService _authService;
  bool _mounted = true;

  AuthCubit(this._authService) : super(AuthInitial());

  @override
  Future<void> close() {
    _mounted = false;
    _authService.dispose();
    return super.close();
  }

  Future<void> login(String email, String password) async {
    // Evita emisiones duplicadas verificando el estado actual
    if (state is AuthLoading) return;

    emit(AuthLoading());

    try {
      final user = await _authService.login(email, password);
      
      if (!_mounted) return; // Evita emisiones si el cubit está cerrado

      if (user != null) {
        emit(AuthSuccess(user));
      } else {
        emit(const AuthError('Error de autenticación'));
      }
    } catch (e) {
      if (_mounted) {
        emit(AuthError(e.toString().replaceFirst('Exception: ', '')));
      }
    }
  }

  void logout() {
    if (_mounted) {
      emit(AuthInitial());
    }
  }
}
