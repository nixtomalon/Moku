import 'package:flutter/material.dart';

class CommentsPage extends StatelessWidget {
  const CommentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
        leading: BackButton(),
      ),
      body: Center(
        child: Text('Comments Page Content'),
      ),
    );
  }
}
