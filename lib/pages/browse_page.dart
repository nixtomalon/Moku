import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BrowsePage extends StatefulWidget {
  const BrowsePage({Key? key}) : super(key: key);

  @override
  _BrowsePageState createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage> {
  late WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            // JavaScript code to remove the mobile-nav, mobile-header, and filters-wrap elements
            _webViewController.runJavaScript("""
              document.querySelector('div.mobile-nav').style.display='none';
              document.querySelector('div.mobile-header').style.display='none'; // Hides the mobile header
              document.querySelector('div.filters-wrap').style.display='none'; // Hides the search and filters wrap
            """);
          },
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 6, // Number of tabs for Anime, Manga, Characters, Staff, Studios, Users
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Browse'),
          centerTitle: false, // Aligns the title to the left
          bottom: const TabBar(
            isScrollable: true, // Makes the tab bar scrollable horizontally
            tabs: [
              Tab(text: 'Anime'),
              Tab(text: 'Manga'),
              Tab(text: 'Characters'),
              Tab(text: 'Staff'),
              Tab(text: 'Studios'),
              Tab(text: 'Users'),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () {
                // Action for the filter button
              },
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                // Toggle the filters-wrap div visibility when the search button is clicked
                _webViewController.runJavaScript("""
                  (function() {
                    var filtersWrap = document.querySelector('div.filters-wrap');
                    filtersWrap.style.display = filtersWrap.style.display === 'none' ? '' : 'none';
                  })();
                """);
              },
            ),
          ],
        ),

        body: TabBarView(
          children: [
            // WebView for the Anime tab
            SizedBox(
              height: screenHeight - 649, // Full height minus appBar and tabBar heights
              child: WebViewWidget(
                controller: _webViewController..loadRequest(Uri.parse('https://anilist.co/search/anime')),
              ),
            ),
            // WebView for the Manga tab
            SizedBox(
              height: screenHeight - 649, // Adjust height as needed
              child: WebViewWidget(
                controller: _webViewController..loadRequest(Uri.parse('https://anilist.co/search/manga')),
              ),
            ),
            const Center(child: Text('Characters Content')),
            const Center(child: Text('Staff Content')),
            const Center(child: Text('Studios Content')),
            const Center(child: Text('Users Content')),
          ],
        ),
      ),
    );
  }
}
