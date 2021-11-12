import 'package:flutter/material.dart';

import 'article.dart';

class ArticleWidget extends StatelessWidget {
  final Article article;

  const ArticleWidget({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 24,
        backgroundImage: NetworkImage(article.avatar),
      ),
      title: Text(
        article.name,
        style: const TextStyle(fontSize: 19),
      ),
    );
  }
}