import 'package:flutter/material.dart';

class AnimePage extends StatelessWidget {
  const AnimePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5, // Number of tabs for Watching, Completed, Paused, Dropped, Planning
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Anime List'),
          centerTitle: false, // Aligns the title to the left
          bottom: const TabBar(
            isScrollable: true, // Allows the tab bar to scroll horizontally
            tabs: [
              Tab(text: 'Watching'),
              Tab(text: 'Completed'),
              Tab(text: 'Paused'),
              Tab(text: 'Dropped'),
              Tab(text: 'Planning'),
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
            Center(child: Text('Watching Content')),
            Center(child: Text('Completed Content')),
            Center(child: Text('Paused Content')),
            Center(child: Text('Dropped Content')),
            Center(child: Text('Planning Content')),
          ],
        ),
      ),
    );
  }
}
