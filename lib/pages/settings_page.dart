import 'package:flutter/material.dart';
import 'appearance_settings_page.dart';
import 'account_page.dart';
import 'about_page.dart';
import 'anilist_settings_page.dart'; // Make sure this import is correct

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.color_lens, color: colorScheme.primary),
            title: const Text('Appearance'),
            subtitle: const Text('Theme'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AppearanceSettingsPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person, color: colorScheme.primary),
            title: const Text('Account'),
            subtitle: const Text('Choose Connected Account'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AccountSettingsPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.launch, color: colorScheme.primary),
            title: const Text('AniList Settings'),
            subtitle: const Text('Profile, Account, Anime & Manga, Lists'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AnilistSettingsPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.info, color: colorScheme.primary),
            title: const Text('About'),
            subtitle: const Text('App Version, Developer Info'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
