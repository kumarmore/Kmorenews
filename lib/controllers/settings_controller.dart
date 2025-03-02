import 'package:get/get.rx.dart';

class SettingsController extends GetxController {
  RxBool isDarkMode = Get.isDarkMode.obs;

  void toggleDarkMode(bool value) {
    isDarkMode.value = value;
    Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
  }
}