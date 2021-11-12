import 'dart:convert';

class Article {
  Article({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  String id;
  DateTime createdAt;
  String name;
  String avatar;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    id: json["id"],
    createdAt: DateTime.parse(json["createdAt"]),
    name: json["name"],
    avatar: json["avatar"],
  );
}
