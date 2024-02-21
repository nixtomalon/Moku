import 'package:flutter/material.dart';

class FollowersPage extends StatelessWidget {
  const FollowersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Followers'),
        leading: BackButton(),
      ),
      body: Center(
        child: Text('Followers Page Content'),
      ),
    );
  }
}
