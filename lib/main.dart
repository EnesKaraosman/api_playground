import 'package:flutter/material.dart';
import 'package:api_playground/articles/articles_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'article.dart';
import 'articles/articles_state.dart';
import 'articles_list.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ArticlesCubit(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ArticlesPage(),
      ),
    );
  }
}

class ArticlesPage extends StatefulWidget {
  const ArticlesPage({Key? key}) : super(key: key);

  @override
  _ArticlesPageState createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  List<Article> articles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () => context.read<ArticlesCubit>().clearArticles(),
            child: const Text(
              "Initial State",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: BlocBuilder<ArticlesCubit, ArticlesState>(
            builder: (context, state) {
              if (state is ArticlesInitial) {
                return ElevatedButton(
                    onPressed: () =>
                        context.read<ArticlesCubit>().fetchArticles(),
                    child: const Text("Fetch Articles"));
              } else if (state is ArticlesFetchSuccess) {
                return ArticlesList(articles: state.articles);
              } else if (state is ArticlesFetchEmpty) {
                return const Text("There is no article to show");
              } else if (state is ArticlesFetchFailed) {
                return Text(state.errorMessage);
              }

              // state is ArticlesLoading
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
