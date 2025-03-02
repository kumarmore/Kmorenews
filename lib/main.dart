import 'package:flutter/material.dart';
import 'package:get/get.rx.dart';
import 'views/home_view.dart';

void main() {
  runApp(GetMaterialApp(
    title: 'G News',
    theme: ThemeData.light(),
    darkTheme: ThemeData.dark(),
    themeMode: ThemeMode.system,
    home: SplashScreen(),
    getPages: [
      GetPage(name: '/home', page: () => HomeView()),
      GetPage(name: '/login', page: () => LoginView()),
      GetPage(name: '/settings', page: () => SettingsView()),
      GetPage(name: '/notifications', page: () => NotificationsView()),
    ],
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(Duration(seconds: 3), () {});
    Get.offNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.newspaper, size: 100, color: Colors.white),
            SizedBox(height: 20),
            Text(
              'G News',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}