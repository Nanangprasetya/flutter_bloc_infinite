import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../users.dart';

part 'user_state.dart';

const _limit = 20;

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserState()) {
    getAllUsers();
  }

  UsersProvider _repository = UsersProvider();

  Future<void> refreshUsers() async {
    emit(state.refresh());
    await getAllUsers();
  }

  Future<void> getAllUsers() async {
    try {
      if (state.hasMax!) return;

      if (state.userStatus == UserStatus.initial) {
        emit(state.copyWith(userStatus: UserStatus.initial));
      }

      final listUser =
          await _repository.getUsers(page: state.page!, limit: _limit);

      final result = state.userStatus == UserStatus.refresh
          ? [...listUser]
          : [...state.data!, ...listUser];

      emit(
        state.copyWith(
          data: result,
          userStatus: UserStatus.success,
          page: state.page! + 1,
          hasMax: listUser.isEmpty,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
          userStatus: UserStatus.failure, errorMessage: e.toString()));
    }
  }

  Future<void> createUser(String? name, String? username) async {
    try {
      final _data =
          UserModel(name: name!, username: username!);
      _repository.createUser(_data);
      refreshUsers();
      
    } catch (e) {
      print(e);
    }
  }
}
