import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../models/article_model.dart';
import '../static/static_values.dart';
import 'package:http/http.dart' as http;

class ArticleController extends GetxController {
  static const base_url =
      'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=e4821d3ee9104b98baf8b0a7099934ef';
  ScrollController scrollController = ScrollController();
  var logger = Logger();

// list of all articles from api
  var articles = [].obs;

  @override
  void onInit() {
    base_url.obs;
    super.onInit();
  }

  Future getArticles() async {
    final response = await http.get(Uri.parse(base_url));

    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      // debugPrint("responseJson -----> $responseJson",wrapWidth: 1024);
      // logger.i(responseJson);
      for (var item in responseJson['articles']) {
        articles.add(Article.fromJson(item));
      }
      //articles.addAll( await responseJson['articles']);
      return articles;
    } else {
      // logger.e('Failed to load articles');
     throw Exception('Failed to load articles');

    }
  }
  // getArticles by category
Future? getArticlesByCategrory({String category = 'business'}) {
  final  _url =
      'https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=e4821d3ee9104b98baf8b0a7099934ef';




}

}


