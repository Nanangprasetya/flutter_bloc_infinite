part of 'user_cubit.dart';

enum UserStatus { initial, refresh, success, failure }

class UserState extends Equatable {
  final UserStatus? status;
  final List<UserModel>? data;
  final bool? hasMax;
  final String errorMessage;
  final int? page;

  const UserState({
    this.status = UserStatus.initial,
    this.data = const <UserModel>[],
    this.hasMax = false,
    this.page = 1,
    this.errorMessage = "",
  });

  UserState copyWith({
    UserStatus? status,
    List<UserModel>? data,
    bool? hasMax,
    int? page,
    String? errorMessage,
  }) {
    return UserState(
      status: status ?? this.status,
      data: data ?? this.data,
      hasMax: hasMax ?? this.hasMax,
      page: page ?? this.page,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  UserState refresh() {
    return UserState(
      status: UserStatus.refresh,
      data: data ?? this.data,
      hasMax: false,
      page: 1,
      errorMessage: "",
    );
  }

  @override
  List<Object?> get props => [status, data, hasMax, errorMessage, page];
}
