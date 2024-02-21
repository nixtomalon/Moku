import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  late WebViewController _controller;

  Future<void> _launchSettings() async {
    final Uri settingsUri = Uri.parse('https://anilist.co/settings/notifications');
    if (await canLaunchUrl(settingsUri)) {
      await launchUrl(settingsUri);
    } else {
      throw 'Could not open $settingsUri';
    }
  }

  @override
    void initState() {
      super.initState();
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onNavigationRequest: (NavigationRequest request) {
              if (request.url.startsWith('https://anilist.co/settings/')) {
                _launchSettings();
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
            onPageFinished: (String url) {
              // JavaScript code to remove the element
              _controller.runJavaScript("""
                document.querySelector('div.mobile-nav').style.display='none';
              """);
            },
          ),
        );
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _launchSettings,
          ),
        ],
      ),
      body: WebViewWidget(
        controller: _controller..loadRequest(Uri.parse('https://anilist.co/notifications')),
      ),
    );
  }
}
