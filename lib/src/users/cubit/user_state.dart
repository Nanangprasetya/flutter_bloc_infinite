part of 'user_cubit.dart';

enum UserStatus { initial, success, failure }

class UserState extends Equatable {
  final UserStatus? status;
  final List<UserModel>? data;
  final bool? hasMax;
  final String errorMessage;

  const UserState({
    this.status = UserStatus.initial,
    this.data = const <UserModel>[],
    this.hasMax = false,
    this.errorMessage = "",
  });

  UserState copyWith({
    UserStatus? status,
    List<UserModel>? data,
    bool? hasMax,
    String? errorMessage,
  }) {
    return UserState(
      status: status ?? this.status,
      data: data ?? this.data,
      hasMax: hasMax ?? this.hasMax,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, data, hasMax, errorMessage];
}
