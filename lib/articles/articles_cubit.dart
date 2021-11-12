import 'package:bloc/bloc.dart';
import '../article.dart';
import 'articles_state.dart';
import 'package:dio/dio.dart';


class ArticlesCubit extends Cubit<ArticlesState> {
  ArticlesCubit() : super(ArticlesInitial());

  Future<List<Article>> _getArticlesDio() async {
    final response = await Dio()
        .get('https://5da476a3a6593f001407a7af.mockapi.io/articles');
    final List<Article> articles =
    List<Article>.from(response.data.map((e) => Article.fromJson(e)));
    return articles;
  }

  clearArticles() => emit(ArticlesInitial());

  Future<void> fetchArticles() async {
    emit(ArticlesLoading());
    try {
      final articles = await _getArticlesDio();
      if (articles.isEmpty) {
        emit(ArticlesFetchEmpty());
      } else {
        emit(ArticlesFetchSuccess(articles));
      }
    } catch(error) {
      emit(ArticlesFetchFailed(error.toString()));
    }
  }
}
