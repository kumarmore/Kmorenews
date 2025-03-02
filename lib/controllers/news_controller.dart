import 'package:get/get.dart';
import '../models/news_model.dart';
import '../services/news_service.dart';

class NewsController extends GetxController {
  final NewsService _newsService = NewsService();
  RxList<NewsModel> newsList = <NewsModel>[].obs;
  RxString selectedCategory = 'general'.obs;
  RxString searchQuery = ''.obs;

  @override
  void onInit() {
    fetchNews();
    super.onInit();
  }

  void fetchNews() async {
    try {
      newsList.value = await _newsService.fetchNews(selectedCategory.value) ?? <NewsModel>[];
    } catch (e) {
      Get.snackbar('Error', 'Failed to load news: $e', snackPosition: SnackPosition.BOTTOM);
      newsList.value = <NewsModel>[]; // Fallback to empty list
    }
  }

  void searchNews(String query) async {
    try {
      searchQuery.value = query.trim();
      if (query.trim().isEmpty) {
        fetchNews();
      } else {
        newsList.value = await _newsService.searchNews(query) ?? <NewsModel>[];
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to search news: $e', snackPosition: SnackPosition.BOTTOM);
      newsList.value = <NewsModel>[]; // Fallback to empty list
    }
  }

  void changeCategory(String category) {
    selectedCategory.value = category;
    fetchNews();
    Get.snackbar('Navigating', 'Switched to ${category.capitalizeFirst!}', snackPosition: SnackPosition.BOTTOM);
  }
}