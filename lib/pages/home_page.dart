import 'package:flutter/material.dart';
import 'notifications_page.dart'; // Ensure this path is correct

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          centerTitle: false, // Aligns the title to the left
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Following'),
              Tab(text: 'Global'),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.email),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const NotificationsPage()),
                );
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your action here
          },
          child: const Icon(Icons.edit),
        ),
        body: const TabBarView(
          children: [
            // Replace these with your actual content widgets for each tab
            Center(child: Text('Following Content')),
            Center(child: Text('Global Content')),
          ],
        ),
      ),
    );
  }
}
