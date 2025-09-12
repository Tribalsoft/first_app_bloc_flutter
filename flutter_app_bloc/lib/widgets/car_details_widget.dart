/// Widget que muestra la lista de usuarios obtenida de la API.
library car_details_widget;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/user_bloc.dart';
import '../bloc/user_state.dart';
import '../bloc/user_event.dart';
import '../models/user.dart';

/// Widget principal para mostrar la lista de usuarios.
/// Utiliza BlocBuilder para reaccionar a cambios en el estado de UserBloc.
class CarDetailsWidget extends StatelessWidget {
  const CarDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc()..add(LoadUsers()),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserLoaded) {
            return _buildUserList(state.users);
          } else if (state is UserError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 48),
                  const SizedBox(height: 16),
                  Text(state.message),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  /// Construye la lista de usuarios con un diseño de tarjetas.
  Widget _buildUserList(List<User> users) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: ListTile(
            title: Text(
              user.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text('Email: ${user.email}'),
                Text('Teléfono: ${user.phone}'),
                Text('Sitio web: ${user.website}'),
              ],
            ),
            isThreeLine: true,
            leading: CircleAvatar(
              child: Text(user.name[0]),
            ),
          ),
        );
      },
    );
  }
}
