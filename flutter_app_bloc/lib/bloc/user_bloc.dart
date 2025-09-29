import 'package:flutter_bloc/flutter_bloc.dart';
import 'user_event.dart';
import 'user_state.dart';
import '../services/user_api_service.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserApiService _userService;

  UserBloc(this._userService) : super(UserInitial()) {
    on<LoadUsers>(
      _onLoadUsers,
      transformer: (events, mapper) =>
          events.distinct().asyncExpand(mapper).takeWhile((_) => !isClosed),
    );
  }

  Future<void> _onLoadUsers(LoadUsers event, Emitter<UserState> emit) async {
    if (isClosed) return;
    emit(UserLoading());

    try {
      final users = await _userService.getAllUsers();
      if (!isClosed) {
        emit(UsersLoaded(users));
      }
    } catch (e) {
      if (!isClosed) {
        emit(UserError(e.toString()));
      }
    }
  }

  @override
  Future<void> close() {
    _userService.dispose();
    return super.close();
  }
}
