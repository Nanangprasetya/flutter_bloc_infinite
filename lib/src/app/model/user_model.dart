class UserModel {
  String? id;
  String? name;
  String? username;
  String? avatar;

  UserModel({this.id, this.name, this.username, this.avatar});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['username'] = this.username;
    return data;
  }
}
