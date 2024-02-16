import 'package:flutter/material.dart';

class ActivityHistoryPage extends StatelessWidget {
  const ActivityHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity History'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Text('Activity history content goes here.'),
      ),
    );
  }
}
