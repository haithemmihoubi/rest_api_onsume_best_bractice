
import 'package:json_annotation/json_annotation.dart';
part 'article_model.g.dart';
@JsonSerializable()
class Article {
  @JsonKey(defaultValue: 'unKnown')
  final String? author;
  final String? title;
  @JsonKey(defaultValue: '')
  final String? description;
  final String? url;
  @JsonKey(name: 'urlToImage', defaultValue: 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png')
  final String? imageUrl;
  final String publishedAt;
  final String? content;
  final ArticleSource source;

  Article(this.author, this.title, this.description, this.url, this.imageUrl,
      this.publishedAt, this.content, this.source);

Article.fromJson(Map<String, dynamic> json)
      : author = json['author'],
        title = json['title'],
        description = json['description'],
        url = json['url'],
        imageUrl = json['urlToImage'],
        publishedAt = json['publishedAt'],
        content = json['content'],
        source = ArticleSource.fromJson(json['source']);


}
//? serializing the sourcea in the article
@JsonSerializable()
class ArticleSource {
  final String? id;
  final String? name;
  ArticleSource({
    this.id,
     this.name,
  });
factory ArticleSource.fromJson(Map<String, dynamic> json) =>
      _$ArticleSourceFromJson(json);


}

