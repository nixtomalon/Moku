import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class OverviewTab extends StatefulWidget {
  const OverviewTab({Key? key}) : super(key: key);

  @override
  State<OverviewTab> createState() => _OverviewTabState();
}

class _OverviewTabState extends State<OverviewTab> {
  final String query = '''
query {
  Viewer {
    about
  }
}
''';

  String aboutContent = '';
  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    fetchAboutContent();
  }

  Future<void> fetchAboutContent() async {
    final accessToken = await storage.read(key: 'access_token');
    final response = await http.post(
      Uri.parse('https://graphql.anilist.co'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode({
        'query': query,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        aboutContent = data['data']['Viewer']['about'] ?? 'No about information found.';
      });
    } else {
      // Handle errors or unsuccessful responses
      print('Failed to fetch user about info');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: MarkdownBody(
                data: aboutContent,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Define the action to be taken when the button is pressed
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
