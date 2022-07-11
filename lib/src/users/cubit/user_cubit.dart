import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../app/app.dart';

part 'user_state.dart';

const _limit = 20;

class UserCubit extends Cubit<UserState> {
  // [UserState()] default status is UserStatus.initial
  UserCubit() : super(UserState()) {
    getAllUsers();
  }

  UsersProvider _repository = UsersProvider();

  Future<void> getAllUsers() async {
    try {
      if (state.hasMax!) return;

      if (state.status == UserStatus.initial) {
        emit(state.copyWith(status: UserStatus.initial));
      }

      final listUser =
          await _repository.getUsers(page: state.page!, limit: _limit);

      final result = state.status == UserStatus.refresh
          ? [...listUser]
          : [...state.data!, ...listUser];

      emit(
        state.copyWith(
          data: result,
          status: UserStatus.success,
          page: state.page! + 1,
          hasMax: listUser.isEmpty,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
          status: UserStatus.failure, errorMessage: e.toString()));
    }
  }

  Future<void> refreshUsers() async {
    emit(state.refresh());
    await getAllUsers();
  }
}
