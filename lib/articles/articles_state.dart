import 'package:flutter/cupertino.dart';
import '../article.dart';

@immutable
abstract class ArticlesState {}

class ArticlesInitial extends ArticlesState {}

class ArticlesLoading extends ArticlesState {}

class ArticlesFetchSuccess extends ArticlesState {
  final List<Article> articles;

  ArticlesFetchSuccess(this.articles);
}

class ArticlesFetchEmpty extends ArticlesState {}

class ArticlesFetchFailed extends ArticlesState {
  final String errorMessage;

  ArticlesFetchFailed(this.errorMessage);
}