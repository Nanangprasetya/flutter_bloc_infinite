part of 'user_cubit.dart';

enum UserStatus { initial, success, failure}

class UserState extends Equatable {
  final UserStatus? userStatus;
  final List<UserModel>? data;
  final bool? hasMax;
  final String errorMessage;
  final int? page;

  const UserState({
    this.userStatus = UserStatus.initial,
    this.data = const <UserModel>[],
    this.hasMax = false,
    this.page = 1,
    this.errorMessage = "",
  });

  UserState copyWith({
    UserStatus? userStatus,
    List<UserModel>? data,
    bool? hasMax,
    int? page,
    String? errorMessage,
  }) {
    return UserState(
      userStatus: userStatus ?? this.userStatus,
      data: data ?? this.data,
      hasMax: hasMax ?? this.hasMax,
      page: page ?? this.page,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  UserState refresh() {
    return UserState(
      userStatus: UserStatus.initial,
      data: data ?? this.data,
      hasMax: false,
      page: 1,
      errorMessage: "",
    );
  }

  @override
  List<Object?> get props => [userStatus, data, hasMax, errorMessage, page];
}
