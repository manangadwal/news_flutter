import 'dart:convert';

import '../models/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];

  ///
  ///
  ///
  Future<void> getNews() async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=4f0602ca37ad4097b688ce47e132a3bf";
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);

    ///
    ///
    ///

    if (jsonData['status'] == 'ok') {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null &&
            element["description"] != null &&
            element['content'] != null) {
          ArticleModel articleModel = ArticleModel(
              content: element['content'],
              desc: element['description'],
              title: element['title'],
              url: element['url'],
              urltoImg: element['urlToImage']);
          news.add(articleModel);
        }
      });
    }
  }
}

class CategoryNewsClass {
  List<ArticleModel> categoryNews = [];

  ///
  ///
  ///
  Future<void> getNews(String category) async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=4f0602ca37ad4097b688ce47e132a3bf";
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);

    ///
    ///
    ///

    if (jsonData['status'] == 'ok') {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null &&
            element["description"] != null &&
            element['content'] != null) {
          ArticleModel articleModel = ArticleModel(
              content: element['content'],
              desc: element['description'],
              title: element['title'],
              url: element['url'],
              urltoImg: element['urlToImage']);
          categoryNews.add(articleModel);
        }
      });
    }
  }
}
