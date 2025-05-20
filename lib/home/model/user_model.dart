import 'dart:convert';

class UserModel {
  final String name;
  final String login;
  final String avatarUrl;
  final String blog;
  UserModel({
    required this.name,
    required this.login,
    required this.avatarUrl,
    required this.blog,
  });

  String get blogUrl => 'https://$blog';

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'login': login});
    result.addAll({'avatar_url': avatarUrl});
    result.addAll({'blog': blog});

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      login: map['login'] ?? '',
      avatarUrl: map['avatar_url'] ?? '',
      blog: map['blog'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
