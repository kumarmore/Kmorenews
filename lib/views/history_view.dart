import 'package:flutter/material.dart';
import 'package:get/get.rx.dart';
import '../controllers/history_controller.dart';
import '../models/news_model.dart';

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
            return ListTile(
              title: Text(news.title),
              subtitle: Text(news.description ?? ''),
            );
          },
        ),
      ),
    );
  }
}