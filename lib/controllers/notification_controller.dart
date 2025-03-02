import 'package:get/get.rx.dart';

class NotificationController extends GetxController {
  RxInt unreadNotifications = 0.obs;

  void addNotification() {
    unreadNotifications.value++;
  }

  void markAsRead() {
    unreadNotifications.value = 0;
    Get.snackbar('Success', 'Notifications marked as read', snackPosition: SnackPosition.BOTTOM);
  }
}