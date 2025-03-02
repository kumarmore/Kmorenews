import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news_model.dart';

class NewsService {
  final String apiKey = 'a6e96725c5aadc9110b37a7382d53067';
  final String baseUrl = 'https://api.gnewsapi.com/v4';

  Future<List<NewsModel>> fetchNews(String category) async {
    final response = await http.get(Uri.parse(
        '$baseUrl/top-headlines?category=$category&lang=en&apikey=$apiKey'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['articles'] as List)
          .map((article) => NewsModel.fromJson(article))
          .toList();
    } else {
      throw Exception('Failed to load news: ${response.statusCode}');
    }
  }

  Future<List<NewsModel>> searchNews(String query) async {
    final response = await http.get(Uri.parse(
        '$baseUrl/search?q=${Uri.encodeQueryComponent(query)}&lang=en&max=10&apikey=$apiKey'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['articles'] as List)
          .map((article) => NewsModel.fromJson(article))
          .toList();
    } else {
      throw Exception('Failed to search news: ${response.statusCode}');
    }
  }
}