part of 'user_cubit.dart';

enum UserStatus { initial, refresh, success, failure, change }
enum UserMethod { get, add, edit, delete }

class UserState extends Equatable {
  final UserMethod? method;
  final UserStatus? userStatus;
  final List<UserModel>? data;
  final bool? hasMax;
  final String errorMessage;
  final int? page;

  const UserState({
    this.method = UserMethod.get,
    this.userStatus = UserStatus.initial,
    this.data = const <UserModel>[],
    this.hasMax = false,
    this.page = 1,
    this.errorMessage = "",
  });

  UserState copyWith({
    UserMethod? method,
    UserStatus? userStatus,
    List<UserModel>? data,
    bool? hasMax,
    int? page,
    String? errorMessage,
  }) {
    return UserState(
      method: method ?? this.method,
      userStatus: userStatus ?? this.userStatus,
      data: data ?? this.data,
      hasMax: hasMax ?? this.hasMax,
      page: page ?? this.page,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  UserState refresh() {
    return UserState(
      method: UserMethod.get,
      userStatus: UserStatus.refresh,
      data: data ?? this.data,
      hasMax: false,
      page: 1,
      errorMessage: "",
    );
  }

  @override
  List<Object?> get props => [method, userStatus, data, hasMax, errorMessage, page];
}
