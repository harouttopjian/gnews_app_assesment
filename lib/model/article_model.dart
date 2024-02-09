import 'source_model.dart';

class Article{
  Source source;
  String title;
  String description;
  String content;
  String url;
  String image;
  String publishedAt;

  Article(
      {
        required this.source,
        required this.title,
        required this.description,
        required this.content,
        required this.url,
        required this.image,
        required this.publishedAt
      });

  factory Article.fromJson(Map<String, dynamic> json){
    return Article(
      source: Source.fromJson(json['source']),
      title: json['title'] as String,
      description: json['description'] as String,
      content: json['content'] as String,
      url: json['url'] as String,
      image: json['image'] as String,
      publishedAt: json['publishedAt'] as String
    );
  }
}