import 'package:flutter/material.dart';
import 'settings_page.dart'; // Import the SettingsPage
import 'activity_history_page.dart'; // Import the ActivityHistoryPage

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          centerTitle: false, // Aligns the title to the left
          bottom: const TabBar(
            isScrollable: true, // Makes the tab bar scrollable
            tabs: [
              Tab(text: 'Overview'),
              Tab(text: 'Favorites'),
              Tab(text: 'Stats'),
              Tab(text: 'Reviews'),
              Tab(text: 'Submissions'),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.history),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ActivityHistoryPage(),
                ));
              },
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ));
              },
            ),
          ],
        ),
        body: const TabBarView(
          children: [
            Center(child: Text('Overview Content')),
            Center(child: Text('Favorites Content')),
            Center(child: Text('Stats Content')),
            Center(child: Text('Reviews Content')),
            Center(child: Text('Submissions Content')),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your action here
          },
          child: const Icon(Icons.edit),
        ),
      ),
    );
  }
}
