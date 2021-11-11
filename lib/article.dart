// To parse this JSON data, do
//
//     final article = articleFromJson(jsonString);

import 'dart:convert';

List<Article> articleFromJson(String str) => List<Article>.from(
    json.decode(str)
        .map((x) => Article.fromJson(x))
);

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
