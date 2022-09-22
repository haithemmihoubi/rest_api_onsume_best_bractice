// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) => Article(
      json['author'] as String? ?? 'unKnown',
      json['title'] as String?,
      json['description'] as String? ?? '',
      json['url'] as String?,
      json['urlToImage'] as String? ??
          'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png',
      json['publishedAt'] as String,
      json['content'] as String?,
      ArticleSource.fromJson(json['source'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'author': instance.author,
      'title': instance.title,
      'description': instance.description,
      'url': instance.url,
      'urlToImage': instance.imageUrl,
      'publishedAt': instance.publishedAt,
      'content': instance.content,
      'source': instance.source,
    };

ArticleSource _$ArticleSourceFromJson(Map<String, dynamic> json) =>
    ArticleSource(
      id: json['id'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$ArticleSourceToJson(ArticleSource instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
