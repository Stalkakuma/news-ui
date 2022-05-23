import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../components/article.dart';
import './details.dart';
import '../components/description.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

const apiUrl =
    'https://newsapi.org/v2/top-headlines?country=lt&apiKey=cad8ea7b8a874eb085cc20adafc25c25';

class _HomePageState extends State<HomePage> {
  late Future<List<NewsArticle>> articles;
  Future<List<NewsArticle>> _fetchArticles() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      var articlesJson = jsonDecode(response.body)['articles'] as List;
      return articlesJson
          .map((article) => NewsArticle.fromJson(article))
          .toList();
    } else {
      throw Exception('Failed to load articles');
    }
  }

  @override
  void initState() {
    super.initState();
    articles = _fetchArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(253, 251, 251, 248),
        appBar: AppBar(
          title: Text(
            'Articles',
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
        ),
        body: RefreshIndicator(
            onRefresh: () {
              return Future.delayed(const Duration(seconds: 1), () {
                setState(() {
                  articles = _fetchArticles();
                });
              });
            },
            child: Center(
              child: FutureBuilder(
                future: articles,
                builder: (context, AsyncSnapshot<List> snapshot) {
                  if (snapshot.hasData) {
                    return Center(
                      child: ListView.separated(
                        itemCount: snapshot.data!.length,
                        padding: const EdgeInsets.all(8),
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            splashColor: Colors.grey,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailsPage(
                                          article: snapshot.data![index])));
                            },
                            child: ArticleDetails(
                              imageUrl: '${snapshot.data![index].imageUrl}',
                              title: '${snapshot.data![index].title}',
                              description:
                                  '${snapshot.data![index].description}',
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(
                          thickness: 1.5,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  }
                  return const CircularProgressIndicator();
                },
              ),
            )));
  }
}
