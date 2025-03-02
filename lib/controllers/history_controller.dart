import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/news_model.dart'; // Ensure correct import path
import 'dart:convert'; // Ensure this import is present

class HistoryController extends GetxController {
  RxList<NewsModel> historyList = <NewsModel>[].obs;
  late SharedPreferences _prefs;

  @override
  void onInit() async {
    super.onInit();
    _prefs = await SharedPreferences.getInstance();
    loadHistory();
  }

  void addToHistory(NewsModel news) {
    if (!historyList.contains(news)) {
      historyList.insert(0, news); // Add to the beginning for recent-first order
      _saveHistory();
    }
    Get.snackbar('Success', 'Added to history', snackPosition: SnackPosition.BOTTOM);
  }

  void loadHistory() {
    final historyJson = _prefs.getStringList('history') ?? [];
    historyList.value = historyJson.map((json) => NewsModel.fromJson(jsonDecode(json))).toList();
  }

  void _saveHistory() {
    final historyJson = historyList.map((news) => jsonEncode(news.toJson())).toList();
    _prefs.setStringList('history', historyJson);
  }

  void clearHistory() {
    historyList.clear();
    _prefs.remove('history');
    Get.snackbar('Success', 'History cleared', snackPosition: SnackPosition.BOTTOM);
  }
}