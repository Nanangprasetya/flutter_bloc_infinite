import '../../src/app/app.dart';

class UserRepository extends BaseApi {
  final repo = 'users';

  Future<List<UserModel>> getUsers(PaginationFilter filter) async {
    final lst = await get('$repo/',
        queryParameters: {'page': filter.page, 'limit': filter.limit});
    return lst.map<UserModel>((value) => UserModel.fromJson(value)).toList();
  }

  Future<UserModel> getByIdUser(int id) async {
    final data = await get('$repo/$id');
    return UserModel.fromJson(data);
  }

  Future<UserModel> createUser(UserModel user) async {
    final data = await post('$repo/', data: user.toJson());
    return UserModel.fromJson(data);
  }

  Future<UserModel> updateUser(int id, UserModel user) async {
    final data = await put('$repo/$id', data: user.toJson());
    return UserModel.fromJson(data);
  }

  Future<UserModel> deleteUser(int id) async {
    final data = await delete('$repo/$id');
    return UserModel.fromJson(data);
  }
}
