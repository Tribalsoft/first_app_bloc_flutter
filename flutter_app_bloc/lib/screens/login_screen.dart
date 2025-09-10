import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';
import '../widgets/login_text_field.dart';
import '../widgets/login_debug_values.dart';
import '../widgets/login_button.dart';
import 'main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _username = '';
  String _password = '';

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar Sesión'),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listenWhen: (previous, current) =>
            current is AuthSuccess || current is AuthError,
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const MainScreen()),
            );
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoginTextField(
                controller: _usernameController,
                label: 'Usuario',
                onChanged: (value) => setState(() => _username = value),
              ),
              const SizedBox(height: 16),
              LoginTextField(
                controller: _passwordController,
                label: 'Contraseña',
                isPassword: true,
                onChanged: (value) => setState(() => _password = value),
              ),
              const SizedBox(height: 24),
              LoginDebugValues(
                username: _username,
                password: _password,
              ),
              const SizedBox(height: 24),
              LoginButton(
                username: _username,
                password: _password,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
