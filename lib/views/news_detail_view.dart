import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/history_controller.dart';
import '../models/news_model.dart';

class NewsDetailView extends StatelessWidget {
  final NewsModel news;

  NewsDetailView({required this.news});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      Get.snackbar('Error', 'Could not launch $url',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    final HistoryController historyController = Get.find<HistoryController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('News Detail'),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              Share.share('${news.title}\n${news.url}');
              Get.snackbar('Shared', 'News shared successfully',
                  snackPosition: SnackPosition.BOTTOM);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (news.image.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  news.image,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      width: double.infinity,
                      height: 200,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: 500,
                      color: Colors.grey[300],
                      child: Center(child: Text('Image not available')),
                    );
                  },
                ),
              ),
            SizedBox(height: 16),
            Text(
              news.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Get.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 16),
            Text(
              news.description,
              style: TextStyle(
                fontSize: 16,
                color: Get.isDarkMode ? Colors.white70 : Colors.black87,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  news.publisher,
                  style: TextStyle(
                    fontSize: 14,
                    color: Get.isDarkMode ? Colors.white60 : Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  news.publishedAt.split('T')[0],
                  style: TextStyle(
                    fontSize: 14,
                    color: Get.isDarkMode ? Colors.white60 : Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => _launchUrl(news.url),
              child: Text('Read More'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
