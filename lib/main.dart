import 'package:flutter/material.dart';
import 'color_schemes.g.dart'; // Make sure this import is correct
import 'pages/home_page.dart';
import 'pages/browse_page.dart';
import 'pages/anime_page.dart';
import 'pages/manga_page.dart';
import 'pages/profile_page.dart';

void main() => runApp(const AniMobileApp());

class AniMobileApp extends StatelessWidget {
  const AniMobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Apply the light theme color scheme
      theme: ThemeData(
        useMaterial3: true, 
        colorScheme: lightColorScheme, // Using lightColorScheme from color_schemes.g.dart
      ),
      // Apply the dark theme color scheme
      darkTheme: ThemeData(
        useMaterial3: true, 
        colorScheme: darkColorScheme, // Using darkColorScheme from color_schemes.g.dart
      ),
      home: const AniMobileNavigation(),
    );
  }
}

class AniMobileNavigation extends StatefulWidget {
  const AniMobileNavigation({super.key});

  @override
  State<AniMobileNavigation> createState() => _AniMobileNavigationState();
}

// No changes needed below this line for theme integration
class _AniMobileNavigationState extends State<AniMobileNavigation> {
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        selectedIndex: _currentPageIndex,
        destinations: const <NavigationDestination>[
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.explore_outlined), selectedIcon: Icon(Icons.explore), label: 'Browse'),
          NavigationDestination(icon: Icon(Icons.video_library_outlined), selectedIcon: Icon(Icons.video_library), label: 'Anime'),
          NavigationDestination(icon: Icon(Icons.collections_bookmark_outlined), selectedIcon: Icon(Icons.collections_bookmark), label: 'Manga'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      body: IndexedStack(
        index: _currentPageIndex,
        children: const <Widget>[
          HomePage(),
          BrowsePage(),
          AnimePage(),
          MangaPage(),
          ProfilePage(),
        ],
      ),
    );
  }
}
