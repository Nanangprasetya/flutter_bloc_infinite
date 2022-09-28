import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? id;
  final String name;
  final String username;

  UserModel({this.id, required this.name, required this.username});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['username'] = this.name;
    return data;
  }

  @override
  List<Object?> get props => [id, name, username];
}
