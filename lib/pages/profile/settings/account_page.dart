import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountSettingsPage extends StatefulWidget {
  const AccountSettingsPage({Key? key}) : super(key: key);

  @override
  _AccountSettingsPageState createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  String _username = 'Username';
  String _avatarUrl = 'lib/assets/default_profile.png';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      throw 'Could not launch $urlString';
    }
  }

  void _showAuthDialog() {
    final TextEditingController _controller = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Authorization'),
          content: TextField(
            controller: _controller,
            decoration: const InputDecoration(hintText: "Paste your code here"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Save'),
              onPressed: () async {
                await _secureStorage.write(key: 'access_token', value: _controller.text);
                Navigator.of(context).pop();
                _fetchAndCacheUserData();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _loadUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? 'Username';
      _avatarUrl = prefs.getString('avatarUrl') ?? 'lib/assets/default_profile.png';
    });
    _fetchAndCacheUserData();
  }

  Future<void> _fetchAndCacheUserData() async {
    final String? accessToken = await _secureStorage.read(key: 'access_token');
    if (accessToken != null) {
      final url = Uri.parse('https://graphql.anilist.co');
      final query = '''
        query {
          Viewer {
            name
            avatar {
              large
            }
          }
        }
      ''';
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'query': query}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final fetchedUsername = data['data']['Viewer']['name'];
        final fetchedAvatarUrl = data['data']['Viewer']['avatar']['large'];

        if (_username != fetchedUsername || _avatarUrl != fetchedAvatarUrl) {
          setState(() {
            _username = fetchedUsername ?? _username;
            _avatarUrl = fetchedAvatarUrl ?? _avatarUrl;
          });
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('username', _username);
          await prefs.setString('avatarUrl', _avatarUrl);
        }
      } else {
        print('Failed to fetch user data');
      }
    }
  }

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
            _avatarUrl.startsWith('lib/assets')
                ? Image.asset(
                    _avatarUrl,
                    width: MediaQuery.of(context).size.width * 0.15,
                    fit: BoxFit.contain,
                  )
                : Image.network(
                    _avatarUrl,
                    width: MediaQuery.of(context).size.width * 0.15,
                    fit: BoxFit.contain,
                  ),
            const SizedBox(height: 10),
            Text(_username, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 5),
            const Divider(),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(Icons.login),
                    title: const Text('Login'),
                    subtitle: const Text('Connect your AniList account'),
                    onTap: () => _launchURL('https://anilist.co/api/v2/oauth/authorize?client_id=16958&response_type=token'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.post_add),
                    title: const Text('Authorization Text'),
                    subtitle: const Text('Paste your authorization text here'),
                    onTap: () => _showAuthDialog(),
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
