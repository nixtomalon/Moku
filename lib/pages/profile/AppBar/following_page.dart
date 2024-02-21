import 'package:flutter/material.dart';

class FollowingPage extends StatelessWidget {
  const FollowingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Following'),
        leading: BackButton(),
      ),
      body: Center(
        child: Text('Following Page Content'),
      ),
    );
  }
}
