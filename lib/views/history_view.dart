import 'package:flutter/material.dart';
import 'package:get/get.rx.dart';
import 'package:animations/animations.dart';
import '../controllers/history_controller.dart';
import '../models/news_model.dart';
import 'news_detail_view.dart';

class HistoryView extends StatelessWidget {
  final HistoryController historyController = Get.put(HistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        actions: [
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () => historyController.clearHistory(),
          ),
        ],
      ),
      body: Obx(
            () => historyController.historyList.isEmpty
            ? Center(child: Text('No history yet'))
            : ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: historyController.historyList.length,
          itemBuilder: (context, index) {
            final news = historyController.historyList[index];
            return OpenContainer(
              transitionDuration: Duration(milliseconds: 500),
              closedBuilder: (context, action) => Card(
                margin: EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: ListTile(
                  title: Text(news.title),
                  subtitle: Text(news.description ?? ''),
                ),
              ),
              openBuilder: (context, action) => NewsDetailView(news: news),
              closedColor: Colors.transparent,
            );
          },
        ),
      ),
    );
  }
}