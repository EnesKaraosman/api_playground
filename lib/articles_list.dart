import 'package:flutter/material.dart';

import 'article.dart';
import 'article_widget.dart';

class ArticlesList extends StatelessWidget {
  const ArticlesList({
    Key? key,
    required this.articles,
  }) : super(key: key);

  final List<Article> articles;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemBuilder: (_, index) => ArticleWidget(article: articles[index]),
        itemCount: articles.length,
        separatorBuilder: (_, __) => const Divider(),
      ),
    );
  }
}