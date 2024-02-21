import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'notifications_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late WebViewController _controller;
  bool _isActivityEditVisible = false; // Add this line

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
          onPageFinished: (String url) {
            _controller.runJavaScript("""
                document.querySelector('div.mobile-nav').style.display='none';
                document.querySelector('div.list-previews').style.display='none';
                document.querySelector('div.activity-edit').style.display='none'; // Initially hide the div
              """);
          },
        ),
      )
      ..loadRequest(Uri.parse('https://anilist.co/home'));
  }

  void _toggleActivityEditVisibility() {
    setState(() {
      _isActivityEditVisible = !_isActivityEditVisible;
      String displayStyle = _isActivityEditVisible ? "block" : "none";
      _controller.runJavaScript("""
          document.querySelector('div.activity-edit').style.display='$displayStyle';
        """);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          centerTitle: false,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Following'),
              Tab(text: 'Global'),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.email),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const NotificationsPage()),
                );
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _toggleActivityEditVisibility, // Updated this line
          child: const Icon(Icons.edit),
        ),
        body: TabBarView(
          children: [
            WebViewWidget(controller: _controller),
            Center(child: Text('Global Content')),
          ],
        ),
      ),
    );
  }
}
