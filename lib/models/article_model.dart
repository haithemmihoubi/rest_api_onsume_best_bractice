
import 'package:json_annotation/json_annotation.dart';
part 'article_model.g.dart';
@JsonSerializable()
class Article {
  @JsonKey(defaultValue: 'unKnown')
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  @JsonKey(name: 'urlToImage')
  final String? imageUrl;
  final String publishedAt;
  final String? content;
  final ArticleSource source;

  Article(this.author, this.title, this.description, this.url, this.imageUrl,
      this.publishedAt, this.content, this.source);

  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleToJson(this);
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

