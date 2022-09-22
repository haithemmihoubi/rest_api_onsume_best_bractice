import 'dart:convert';

import 'package:get/get.dart';

import '../models/article_model.dart';
import '../static/static_values.dart';
import 'package:http/http.dart' as http;

class ArticleController extends GetxController {
  static const base_url  = 'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=e4821d3ee9104b98baf8b0a7099934ef';

// list of all articles from api
  var articles = [].obs;
  @override
  void onInit() {
    base_url.obs;
    super.onInit();
  }


 Future getArticles() async {
final response = await http.get(Uri.parse(base_url));
print("response -----> $response.articles",) ;
if (response.statusCode == 200) {
var responseJson = json.decode(response.body);
for (var item in responseJson['articles']) {
articles.add(Article.fromJson(item));
print("articles lklist -----> ${articles.length}",) ;
}

return articles;
} else {
  throw Exception('Failed to load articles');
}
}



}








