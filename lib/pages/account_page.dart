import 'package:flutter/material.dart';

class AccountSettingsPage extends StatelessWidget {
  const AccountSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 30),
            Image.asset(
              'lib/assets/default_profile.png',
              width: MediaQuery.of(context).size.width * 0.15,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 10),
            const Text('Username', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 5),
            const Divider(),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.login), // Icon for the login item
                    title: Text('Login'),
                    subtitle: Text('Connect your AniList account'),
                    onTap: () {
                      // Handle login tap
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
