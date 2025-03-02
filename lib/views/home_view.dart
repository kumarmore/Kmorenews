// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:animations/animations.dart';
// import 'package:share_plus/share_plus.dart';
// import '../controllers/news_controller.dart';
// import '../models/news_model.dart';
// import '../controllers/theme_controller.dart';
// import '../controllers/history_controller.dart';
// import '../controllers/auth_controller.dart';
// import '../controllers/settings_controller.dart';
// import '../controllers/notification_controller.dart';
// import 'news_detail_view.dart';
// import 'history_view.dart';
// import 'login_view.dart';
// import 'settings_view.dart';
// import 'notifications_view.dart';
//
// class HomeView extends StatelessWidget {
//   final NewsController newsController = Get.put(NewsController());
//   final ThemeController themeController = Get.put(ThemeController());
//   final HistoryController historyController = Get.put(HistoryController());
//   final AuthController authController = Get.put(AuthController());
//   final SettingsController settingsController = Get.put(SettingsController());
//   final NotificationController notificationController = Get.put(NotificationController());
//   final List<String> categories = [
//     'general',
//     'sports',
//     'technology',
//     'politics',
//     'business',
//     'entertainment',
//   ];
//   final TextEditingController searchController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: categories.length,
//       initialIndex: 0,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('G News'),
//           actions: [
//             Obx(
//                   () => IconButton(
//                 icon: Icon(themeController.isDarkMode.value
//                     ? Icons.light_mode
//                     : Icons.dark_mode),
//                 onPressed: themeController.toggleTheme,
//               ),
//             ),
//             IconButton(
//               icon: Icon(Icons.search),
//               onPressed: () {
//                 _showSearchDialog(context);
//               },
//             ),
//           ],
//           bottom: PreferredSize(
//             preferredSize: Size.fromHeight(48.0),
//             child: TabBar(
//               isScrollable: true,
//               tabs: categories
//                   .map((category) => Tab(text: category.capitalizeFirst!))
//                   .toList(),
//               onTap: (index) {
//                 newsController.changeCategory(categories[index]);
//               },
//             ),
//           ),
//         ),
//         drawer: Drawer(
//           child: ListView(
//             padding: EdgeInsets.zero,
//             children: [
//               DrawerHeader(
//                 decoration: BoxDecoration(
//                   color: Get.isDarkMode ? Colors.purple[900] : Colors.purple,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'G News',
//                       style: TextStyle(color: Colors.white, fontSize: 24),
//                     ),
//                     Obx(
//                           () => Text(
//                         authController.isLoggedIn.value
//                             ? 'Welcome, ${authController.userName.value}'
//                             : 'Guest',
//                         style: TextStyle(color: Colors.white70, fontSize: 14),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               ...categories.map((category) => ListTile(
//                 title: Text(category.capitalizeFirst!),
//                 onTap: () {
//                   newsController.changeCategory(category);
//                   searchController.clear();
//                   Get.back();
//                   Get.snackbar('Navigating', 'Switched to ${category.capitalizeFirst!}',
//                       snackPosition: SnackPosition.BOTTOM);
//                 },
//               )),
//               Obx(
//                     () => SwitchListTile(
//                   title: Text('Dark Mode'),
//                   value: themeController.isDarkMode.value,
//                   onChanged: (value) => themeController.toggleTheme(),
//                 ),
//               ),
//               ListTile(
//                 title: Text('History'),
//                 onTap: () {
//                   Get.to(() => HistoryView());
//                   Get.back();
//                   Get.snackbar('Navigating', 'Going to History screen',
//                       snackPosition: SnackPosition.BOTTOM);
//                 },
//               ),
//               Obx(
//                     () => ListTile(
//                   title: Text(authController.isLoggedIn.value ? 'Logout' : 'Login'),
//                   onTap: () {
//                     if (authController.isLoggedIn.value) {
//                       authController.logout();
//                     } else {
//                       Get.toNamed('/login');
//                     }
//                     Get.back();
//                     Get.snackbar('Navigating',
//                         authController.isLoggedIn.value ? 'Logged out' : 'Going to Login screen',
//                         snackPosition: SnackPosition.BOTTOM);
//                   },
//                 ),
//               ),
//               ListTile(
//                 title: Text('Settings'),
//                 onTap: () {
//                   Get.toNamed('/settings');
//                   Get.back();
//                   Get.snackbar('Navigating', 'Going to Settings screen',
//                       snackPosition: SnackPosition.BOTTOM);
//                 },
//               ),
//               ListTile(
//                 title: Text('Notifications'),
//                 onTap: () {
//                   Get.toNamed('/notifications');
//                   Get.back();
//                   Get.snackbar('Navigating', 'Going to Notifications screen',
//                       snackPosition: SnackPosition.BOTTOM);
//                 },
//               ),
//             ],
//           ),
//         ),
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Breaking News Section
//             Padding(
//               padding: EdgeInsets.all(16),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Breaking News',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Get.isDarkMode ? Colors.white : Colors.black,
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: () {},
//                     child: Text('View all', style: TextStyle(color: Colors.blue)),
//                   ),
//                 ],
//               ),
//             ),
//             // Breaking News Card with Animation
//             Obx(
//                   () => newsController.newsList.isNotEmpty
//                   ? Card(
//                 margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 elevation: 4,
//                 child: OpenContainer(
//                   transitionDuration: Duration(milliseconds: 500),
//                   closedBuilder: (context, action) => Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
//                         child: Image.network(
//                           newsController.newsList[0].image,
//                           width: double.infinity,
//                           height: 200,
//                           fit: BoxFit.cover,
//                           errorBuilder: (context, error, stackTrace) {
//                             return Container(
//                               width: double.infinity,
//                               height: 200,
//                               color: Colors.grey[300],
//                               child: Center(child: Text('Image not available')),
//                             );
//                           },
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.all(12),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               newsController.newsList[0].title,
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: Get.isDarkMode ? Colors.white : Colors.black,
//                               ),
//                             ),
//                             SizedBox(height: 4),
//                             Text(
//                               'Published ${newsController.newsList[0].publishedAt.split('T')[0]}',
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 color: Get.isDarkMode ? Colors.white60 : Colors.grey,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   openBuilder: (context, action) => NewsDetailView(news: newsController.newsList[0]),
//                   closedColor: Colors.transparent,
//                 ),
//               )
//                   : SizedBox.shrink(),
//             ),
//             // Recommendations Section
//             Padding(
//               padding: EdgeInsets.all(16),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Recommendation',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Get.isDarkMode ? Colors.white : Colors.black,
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: () {},
//                     child: Text('View all', style: TextStyle(color: Colors.blue)),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: TabBarView(
//                 children: categories.map((category) {
//                   return Obx(
//                         () => newsController.newsList.isEmpty
//                         ? Center(child: CircularProgressIndicator())
//                         : ListView.builder(
//                       padding: EdgeInsets.symmetric(horizontal: 16),
//                       itemCount: newsController.newsList.length,
//                       itemBuilder: (context, index) {
//                         final news = newsController.newsList[index];
//                         return OpenContainer(
//                           transitionDuration: Duration(milliseconds: 500),
//                           closedBuilder: (context, action) => Card(
//                             margin: EdgeInsets.only(bottom: 12),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             elevation: 4,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 ClipRRect(
//                                   borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
//                                   child: Image.network(
//                                     news.image,
//                                     width: double.infinity,
//                                     height: 150,
//                                     fit: BoxFit.cover,
//                                     errorBuilder: (context, error, stackTrace) {
//                                       return Container(
//                                         width: double.infinity,
//                                         height: 150,
//                                         color: Colors.grey[300],
//                                         child: Center(child: Text('Image not available')),
//                                       );
//                                     },
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.all(12),
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         news.title,
//                                         style: TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold,
//                                           color: Get.isDarkMode ? Colors.white : Colors.black,
//                                         ),
//                                       ),
//                                       SizedBox(height: 4),
//                                       Text(
//                                         news.description ?? '',
//                                         style: TextStyle(
//                                           fontSize: 14,
//                                           color: Get.isDarkMode ? Colors.white70 : Colors.black87,
//                                         ),
//                                         maxLines: 2,
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                       SizedBox(height: 8),
//                                       Row(
//                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text(
//                                             news.publisher,
//                                             style: TextStyle(
//                                               fontSize: 12,
//                                               color: Get.isDarkMode ? Colors.white60 : Colors.grey,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                           Text(
//                                             news.publishedAt.split('T')[0],
//                                             style: TextStyle(
//                                               fontSize: 12,
//                                               color: Get.isDarkMode ? Colors.white60 : Colors.grey,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       SizedBox(height: 8),
//                                       Row(
//                                         mainAxisAlignment: MainAxisAlignment.end,
//                                         children: [
//                                           IconButton(
//                                             icon: Icon(Icons.share, color: Get.isDarkMode ? Colors.white : Colors.black),
//                                             onPressed: () {
//                                               Share.share('${news.title}\n${news.url}');
//                                               Get.snackbar('Shared', 'News shared successfully', snackPosition: SnackPosition.BOTTOM);
//                                             },
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           openBuilder: (context, action) => NewsDetailView(news: news),
//                           closedColor: Colors.transparent,
//                         );
//                       },
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _showSearchDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Search News'),
//         content: TextField(
//           controller: searchController,
//           decoration: InputDecoration(
//             hintText: 'Enter search query...',
//             border: OutlineInputBorder(),
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               newsController.searchNews(searchController.text);
//               Get.back();
//               Get.snackbar('Searching', 'Searching for "${searchController.text}"', snackPosition: SnackPosition.BOTTOM);
//             },
//             child: Text('Search'),
//           ),
//           TextButton(
//             onPressed: () => Get.back(),
//             child: Text('Cancel'),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animations/animations.dart';
import 'package:share_plus/share_plus.dart';
import '../controllers/news_controller.dart';
import '../models/news_model.dart';
import '../controllers/theme_controller.dart';
import '../controllers/history_controller.dart';
import '../controllers/auth_controller.dart';
import '../controllers/settings_controller.dart';
import '../controllers/notification_controller.dart';
import 'news_detail_view.dart';
import 'history_view.dart';
import 'login_view.dart';
import 'settings_view.dart';
import 'notifications_view.dart';

class HomeView extends StatelessWidget {
  final NewsController newsController = Get.put(NewsController());
  final ThemeController themeController = Get.put(ThemeController());
  final HistoryController historyController = Get.put(HistoryController());
  final AuthController authController = Get.put(AuthController());
  final SettingsController settingsController = Get.put(SettingsController());
  final NotificationController notificationController =
      Get.put(NotificationController());
  final TextEditingController searchController = TextEditingController();
  final List<String> categories = [
    'general',
    'sports',
    'technology',
    'politics',
    'business',
    'entertainment',
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.length,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: _buildSearchBox(), // Centered search box
          actions: [
            Obx(
              () => IconButton(
                icon: Icon(themeController.isDarkMode.value
                    ? Icons.light_mode
                    : Icons.dark_mode),
                onPressed: themeController.toggleTheme,
              ),
            ),
          ],
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: Colors.white,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            tabs: categories
                .map((category) => Tab(text: category.capitalizeFirst!))
                .toList(),
            onTap: (index) => newsController.changeCategory(categories[index]),
          ),
        ),
        drawer: _buildDrawer(),
        body: Column(
          children: [
            // Breaking News Section
            _buildBreakingNewsSection(),
            // Recommendations Section
            _buildRecommendationsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBox() {
    return Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
        color: Get.isDarkMode ? Colors.grey[800] : Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: 'Search news...',
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
        ),
        onSubmitted: (query) {
          newsController.searchNews(query);
        },
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Get.isDarkMode ? Colors.purple[900] : Colors.purple,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'G News',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                Obx(
                  () => Text(
                    authController.isLoggedIn.value
                        ? 'Welcome, ${authController.userName.value}'
                        : 'Guest',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          ...categories.map((category) => ListTile(
                title: Text(category.capitalizeFirst!),
                onTap: () {
                  newsController.changeCategory(category);
                  searchController.clear();
                  Get.back();
                  Get.snackbar(
                      'Navigating', 'Switched to ${category.capitalizeFirst!}',
                      snackPosition: SnackPosition.BOTTOM);
                },
              )),
          Obx(
            () => SwitchListTile(
              title: Text('Dark Mode'),
              value: themeController.isDarkMode.value,
              onChanged: (value) => themeController.toggleTheme(),
            ),
          ),
          ListTile(
            title: Text('History'),
            onTap: () {
              Get.to(() => HistoryView());
              Get.back();
              Get.snackbar('Navigating', 'Going to History screen',
                  snackPosition: SnackPosition.BOTTOM);
            },
          ),
          Obx(
            () => ListTile(
              title: Text(authController.isLoggedIn.value ? 'Logout' : 'Login'),
              onTap: () {
                if (authController.isLoggedIn.value) {
                  authController.logout();
                } else {
                  Get.toNamed('/login');
                }
                Get.back();
                Get.snackbar(
                    'Navigating',
                    authController.isLoggedIn.value
                        ? 'Logged out'
                        : 'Going to Login screen',
                    snackPosition: SnackPosition.BOTTOM);
              },
            ),
          ),
          ListTile(
            title: Text('Settings'),
            onTap: () {
              Get.toNamed('/settings');
              Get.back();
              Get.snackbar('Navigating', 'Going to Settings screen',
                  snackPosition: SnackPosition.BOTTOM);
            },
          ),
          ListTile(
            title: Text('Notifications'),
            onTap: () {
              Get.toNamed('/notifications');
              Get.back();
              Get.snackbar('Navigating', 'Going to Notifications screen',
                  snackPosition: SnackPosition.BOTTOM);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBreakingNewsSection() {
    return Obx(
      () => newsController.newsList.isNotEmpty
          ? Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Breaking News',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  OpenContainer(
                    transitionDuration: Duration(milliseconds: 500),
                    closedBuilder: (context, action) => Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      elevation: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20)),
                            child: Image.network(
                              newsController.newsList[0].image,
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: double.infinity,
                                  height: 200,
                                  color: Colors.grey[300],
                                  child: Center(
                                      child: Text('Image not available')),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  newsController.newsList[0].title,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Published ${newsController.newsList[0].publishedAt.split('T')[0]}',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    openBuilder: (context, action) =>
                        NewsDetailView(news: newsController.newsList[0]),
                  ),
                ],
              ),
            )
          : SizedBox.shrink(),
    );
  }

  Widget _buildRecommendationsSection() {
    return Expanded(
      child: Obx(
        () => newsController.newsList.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: newsController.newsList.length,
                itemBuilder: (context, index) {
                  final news = newsController.newsList[index];
                  return OpenContainer(
                    transitionDuration: Duration(milliseconds: 500),
                    closedBuilder: (context, action) => Card(
                      margin: EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      elevation: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20)),
                            child: Image.network(
                              news.image,
                              width: double.infinity,
                              height: 300,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: double.infinity,
                                  height: 150,
                                  color: Colors.grey[300],
                                  child: Center(
                                      child: Text('Image not available')),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  news.title,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  news.description ?? '',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.blueGrey),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      news.publisher,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      news.publishedAt.split('T')[0],
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    openBuilder: (context, action) =>
                        NewsDetailView(news: news),
                  );
                },
              ),
      ),
    );
  }
}
