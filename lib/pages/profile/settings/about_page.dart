import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String _appVersion = "";

  Future<void> _launchURL(BuildContext context, String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $urlString')),
      );
    }
  }

  void getAppDetails() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() => _appVersion = packageInfo.version);
  }

  @override
  void initState() {
    super.initState();
    getAppDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
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
              'lib/assets/logo.png',
              width: MediaQuery.of(context).size.width * 0.15,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 30),
            const Divider(),
            Flexible(
              child: ListView(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    title: Text("Version"),
                    subtitle: _appVersion.isEmpty
                        ? Text("Loading...")
                        : Text(_appVersion),
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 0,
                    ),
                    title: const Text("What's new"),
                    onTap: () => _launchURL(
                        context, 'https://github.com/Maclean-D/Moku/releases'),
                  ),
                  // Add more ListTiles here for additional items
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.code),
              onPressed: () =>
                  _launchURL(context, 'https://github.com/Maclean-D/Moku'),
            ),
            // Add more widgets here if needed
          ],
        ),
      ),
    );
  }
}
