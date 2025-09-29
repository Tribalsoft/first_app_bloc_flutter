import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/user_bloc.dart';
import '../bloc/user_event.dart';
import '../widgets/user_list_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Cargar usuarios cuando se crea la pantalla
    context.read<UserBloc>().add(LoadUsers());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Usuarios'),
        automaticallyImplyLeading: false,
      ),
      body: const UserListWidget(),
    );
  }
}
