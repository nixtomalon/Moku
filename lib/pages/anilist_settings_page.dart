import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AnilistSettingsPage extends StatelessWidget {
  const AnilistSettingsPage({Key? key}) : super(key: key);

Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      throw 'Could not launch $urlString';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Access the current color scheme from the theme
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('AniList Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.face, color: colorScheme.primary), // Apply primary color
            title: const Text('Profile'),
            subtitle: const Text('Profile, Donator Badge, About, Timezone'),
            onTap: () => _launchURL('https://anilist.co/settings/'),
          ),
          ListTile(
            leading: Icon(Icons.person, color: colorScheme.primary), // Apply primary color
            title: const Text('Account'),
            subtitle: const Text('User Name, Email, Password, Privacy & Security'),
            onTap: () => _launchURL('https://anilist.co/settings/account'),
          ),
          ListTile(
            leading: Icon(Icons.language, color: colorScheme.primary), // Apply primary color
            title: const Text('Anime & Manga'),
            subtitle: const Text('Title, Staff, & Character Language, NSFW'),
            onTap: () => _launchURL('https://anilist.co/settings/media'),
          ),
          ListTile(
            leading: Icon(Icons.list, color: colorScheme.primary), // Apply primary color
            title: const Text('Lists'),
            subtitle: const Text('Scoring, Custom Lists, Update Stats'),
            onTap: () => _launchURL('https://anilist.co/settings/lists'),
          ),
          ListTile(
            leading: Icon(Icons.notifications, color: colorScheme.primary), // Apply primary color
            title: const Text('Notifications'),
            subtitle: const Text('Activity Subscriptions, Social, Site Data Changes'),
            onTap: () => _launchURL('https://anilist.co/settings/notifications'),
          ),
          ListTile(
            leading: Icon(Icons.playlist_add, color: colorScheme.primary), // Apply primary color
            title: const Text('Import'),
            subtitle: const Text('Import data from MyAnimeList'),
            onTap: () => _launchURL('https://anilist.co/settings/import'),
          ),
        ],
      ),
    );
  }
}
