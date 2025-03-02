import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news_model.dart';

class NewsService {
  final String apiKey = 'a6e96725c5aadc9110b37a7382d53067';
  final String baseUrl = 'https://gnews.io/api/v4';

  Future<List<NewsModel>> fetchNews(String category) async {
    final url = '$baseUrl/top-headlines?category=$category&apikey=$apiKey';
    print('Fetching news from: $url');
    return _fetchData(url);
  }

  Future<List<NewsModel>> searchNews(String query) async {
    final url = '$baseUrl/search?q=${Uri.encodeQueryComponent(query)}&apikey=$apiKey';
    print('Searching news from: $url');
    return _fetchData(url);
  }

  Future<List<NewsModel>> _fetchData(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return (data['articles'] as List)
            .map((article) => NewsModel.fromJson(article))
            .toList();
      } else {
        throw Exception('Failed to load data: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Network error: $e');
      throw Exception('Network error: $e');
    }
  }
}