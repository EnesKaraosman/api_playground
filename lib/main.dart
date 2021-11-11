import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'article.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ArticlesPage(),
    );
  }
}

class ArticlesPage extends StatefulWidget {
  const ArticlesPage({Key? key}) : super(key: key);

  @override
  _ArticlesPageState createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  Future<List<Article>> getArticles() async {
    final response = await http
        .get(Uri.parse('https://5da476a3a6593f001407a7af.mockapi.io/articles'));
    final List<Article> articles = List<Article>.from(
        jsonDecode(response.body).map((x) => Article.fromJson(x)));
    return articles;
  }

  Future<List<Article>> getArticlesDio() async {
    final response = await Dio()
        .get('https://5da476a3a6593f001407a7af.mockapi.io/articles');
        // .getUri(Uri.parse('https://5da476a3a6593f001407a7af.mockapi.io/articles'));
    final List<Article> articles =
        List<Article>.from(response.data.map((ferid) => Article.fromJson(ferid)));
    return articles;
  }

  List<Article> articles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                articles = [];
              });
            },
            child: const Text("Clear Articles", style: TextStyle(color: Colors.white),),
          ),
        ],
      ),

      // body: FutureBuilder<List<Article>>(
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      //       articles = snapshot.data!;
      //       return SafeArea(child: RefreshIndicator(
      //         onRefresh: () async {
      //           setState(() {
      //             debugPrint("setState");
      //             articles = [];
      //           });
      //           await getArticles();
      //           debugPrint("articles fetched");
      //         },
      //           child: ArticlesList(articles: articles))
      //       );
      //     } else if (snapshot.hasError) {
      //       return const Text("Failed to get articles!!");
      //     }
      //     return const Center(child: CircularProgressIndicator());
      //   },
      //   // future: getArticlesDio(),
      //   future: getArticles(),
      // ),

      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                OutlinedButton(
                  onPressed: () async {
                    final _articles = await getArticles();
                    setState(() {
                      articles = _articles;
                    });
                  },
                  child: const Text("Fetch Articles"),
                ),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      articles = [];
                    });
                  },
                  child: const Text("Clear Articles"),
                ),
              ],
            ),
            // if (articles != null)
            //   ArticlesList(articles: articles)
            Expanded(
              child: RefreshIndicator(
                  onRefresh: () async {
                    setState(() {
                      debugPrint("setState");
                      articles = [];
                    });
                    final _articles = await getArticles();
                    setState(() {
                      articles  = _articles;
                    });
                    debugPrint("articles fetched");
                  },
                  child: ArticlesList(articles: articles)),
            )
          ],
        ),
      ),

    );
  }
}

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
