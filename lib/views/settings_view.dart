import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends StatelessWidget {
  final SettingsController settingsController = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: ListView(
        children: [
          Obx(
                () => SwitchListTile(
              title: Text('Dark Mode'),
              value: settingsController.isDarkMode.value,
              onChanged: settingsController.toggleDarkMode,
            ),
          ),
        ],
      ),
    );
  }
}