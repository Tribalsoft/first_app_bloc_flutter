import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> login(String username, String password) async {
    emit(AuthLoading());
    await Future.delayed(const Duration(seconds: 2));

    if (username == 'error') {
      emit(const AuthError('Credenciales inválidas'));
    } else {
      emit(AuthSuccess());
    }
  }
}
