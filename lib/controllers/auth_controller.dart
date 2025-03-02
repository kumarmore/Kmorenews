import 'package:get/get.dart';

class AuthController extends GetxController {
  RxBool isLoggedIn = false.obs;
  RxString userName = ''.obs;

  void login(String username, String password) {
    isLoggedIn.value = true;
    userName.value = username;
    Get.snackbar('Success', 'Logged in as $username', snackPosition: SnackPosition.BOTTOM);
  }

  void logout() {
    isLoggedIn.value = false;
    userName.value = '';
    Get.snackbar('Success', 'Logged out', snackPosition: SnackPosition.BOTTOM);
  }
}