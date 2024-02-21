import 'package:flutter/material.dart';

class ThreadsPage extends StatelessWidget {
  const ThreadsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Threads'),
        leading: BackButton(),
      ),
      body: Center(
        child: Text('Threads Page Content'),
      ),
    );
  }
}
