import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/notification_controller.dart';

class NotificationsView extends StatelessWidget {
  final NotificationController notificationController = Get.find<NotificationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notifications')),
      body: Column(
        children: [
          Text('Notifications will appear here'),
          ElevatedButton(
            onPressed: notificationController.markAsRead,
            child: Text('Mark All as Read'),
          ),
        ],
      ),
    );
  }
}