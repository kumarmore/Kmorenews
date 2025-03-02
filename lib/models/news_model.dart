import 'dart:convert';

class NewsModel {
  final String title;
  final String description;
  final String url;
  final String image;
  final String publishedAt;
  final String publisher;

  NewsModel({
    required this.title,
    required this.description,
    required this.url,
    required this.image,
    required this.publishedAt,
    required this.publisher,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      image: json['image'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
      publisher: json['source']['name'] ?? '',
    );
  }
}

extension NewsModelExtension on NewsModel {
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'url': url,
      'image': image,
      'publishedAt': publishedAt,
      'publisher': publisher,
    };
  }
}