import 'package:flutter/material.dart';

class BrowsePage extends StatelessWidget {
  const BrowsePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6, // Number of tabs for Anime, Manga, Characters, Staff, Studios, Users
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Browse'),
          centerTitle: false, // Aligns the title to the left
          bottom: const TabBar(
            isScrollable: true, // Makes the tab bar scrollable horizontally
            tabs: [
              Tab(text: 'Anime'),
              Tab(text: 'Manga'),
              Tab(text: 'Characters'),
              Tab(text: 'Staff'),
              Tab(text: 'Studios'),
              Tab(text: 'Users'),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () {
                // Action for the filter button
              },
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                // Action for the search button
              },
            ),
          ],
        ),
        body: const TabBarView(
          children: [
            // Replace these with your actual content widgets for each tab
            Center(child: Text('Anime Content')),
            Center(child: Text('Manga Content')),
            Center(child: Text('Characters Content')),
            Center(child: Text('Staff Content')),
            Center(child: Text('Studios Content')),
            Center(child: Text('Users Content')),
          ],
        ),
      ),
    );
  }
}
