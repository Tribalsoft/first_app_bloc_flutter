import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'user_event.dart';
import 'user_state.dart';
import '../models/user.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<LoadUsers>(_onLoadUsers);
  }

  Future<void> _onLoadUsers(LoadUsers event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/users'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        final List<User> users = jsonList.map((json) => User.fromJson(json)).toList();
        emit(UserLoaded(users));
      } else {
        emit(const UserError('Error al cargar los usuarios'));
      }
    } catch (e) {
      emit(UserError('Error: ${e.toString()}'));
    }
  }
}