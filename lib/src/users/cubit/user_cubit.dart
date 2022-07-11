import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../app/app.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserState());
}
