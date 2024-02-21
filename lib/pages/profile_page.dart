import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'profile/settings/settings_page.dart';
import 'profile/AppBar/activity_history_page.dart';
import 'profile/AppBar/following_page.dart';
import 'profile/AppBar/followers_page.dart';
import 'profile/AppBar/threads_page.dart';
import 'profile/AppBar/comments_page.dart';
import 'profile/tabs/overview_tab.dart';
import 'profile/tabs/anime_list_tab.dart';
import 'profile/tabs/manga_list_tab.dart';
import 'profile/tabs/favorites_tab.dart';
import 'profile/tabs/stats_tab.dart';
import 'profile/tabs/reviews_tab.dart';
import 'profile/tabs/submissions_tab.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  String _username = 'Username';
  String _avatarUrl = 'lib/assets/default_profile.png';
  String? _donatorBadge;
  int _totalAnime = 0;
  int _totalManga = 0;

  @override
  void initState() {
    _loadAndFetchUserProfile();
    super.initState();
  }

  Future<void> _loadAndFetchUserProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? 'Username';
      _avatarUrl =
          prefs.getString('avatarUrl') ?? 'lib/assets/default_profile.png';
      _donatorBadge =
          prefs.getString('donatorBadge'); // Could be a custom phrase or null
      _totalAnime = prefs.getInt('totalAnime') ?? 0;
      _totalManga = prefs.getInt('totalManga') ?? 0;
    });

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
            donatorBadge
            statistics {
              anime {
                count
              }
              manga {
                count
              }
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
        final fetchedDonatorBadge = data['data']['Viewer']['donatorBadge'];
        final fetchedTotalAnime =
            data['data']['Viewer']['statistics']['anime']['count'];
        final fetchedTotalManga =
            data['data']['Viewer']['statistics']['manga']['count'];

        if (_username != fetchedUsername ||
            _avatarUrl != fetchedAvatarUrl ||
            _donatorBadge != fetchedDonatorBadge ||
            _totalAnime != fetchedTotalAnime ||
            _totalManga != fetchedTotalManga) {
          setState(() {
            _username = fetchedUsername ?? _username;
            _avatarUrl = fetchedAvatarUrl ?? _avatarUrl;
            _donatorBadge = fetchedDonatorBadge;
            _totalAnime = fetchedTotalAnime ?? _totalAnime;
            _totalManga = fetchedTotalManga ?? _totalManga;
          });
          await prefs.setString('username', _username);
          await prefs.setString('avatarUrl', _avatarUrl);
          await prefs.setInt('totalAnime', _totalAnime);
          await prefs.setInt('totalManga', _totalManga);
          if (fetchedDonatorBadge != null && fetchedDonatorBadge.isNotEmpty) {
            await prefs.setString('donatorBadge', fetchedDonatorBadge);
          } else {
            await prefs.remove(
                'donatorBadge'); // Ensure no badge is stored if not present
          }
        }
      } else {
        print('Failed to fetch user data');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 74.0,
          leading: Padding(
            padding: EdgeInsets.only(left: 12.0), // Add left padding
            child: _avatarUrl.startsWith('lib/assets')
                ? Image.asset(_avatarUrl)
                : Image.network(_avatarUrl, fit: BoxFit.fitWidth),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(_username, style: TextStyle(fontSize: 18)),
              if (_donatorBadge != null && _donatorBadge!.isNotEmpty)
                Text(_donatorBadge!, style: TextStyle(fontSize: 14)),
            ],
          ),
          centerTitle: false,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(94.0), // Adjusted for new layout
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                            '${_totalAnime} Total Anime   ${_totalManga} Total Manga',
                            style: TextStyle(fontSize: 14)),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const FollowingPage(),
                          ));
                        },
                        child:
                            Text('Following  ', style: TextStyle(fontSize: 14)),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const FollowersPage(),
                          ));
                        },
                        child: Text('Followers   ',
                            style: TextStyle(fontSize: 14)),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ThreadsPage(),
                          ));
                        },
                        child:
                            Text('Threads   ', style: TextStyle(fontSize: 14)),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const CommentsPage(),
                          ));
                        },
                        child:
                            Text('Comments   ', style: TextStyle(fontSize: 14)),
                      ),
                    ],
                  ),
                ),
                TabBar(
                  isScrollable: true,
                  tabs: [
                    Tab(text: 'Overview'),
                    Tab(text: 'Anime List'),
                    Tab(text: 'Manga List'),
                    Tab(text: 'Favorites'),
                    Tab(text: 'Stats'),
                    Tab(text: 'Reviews'),
                    Tab(text: 'Submissions'),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.history),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ActivityHistoryPage(),
                ));
              },
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ));
              },
            ),
          ],
        ),
        body: const TabBarView(
          children: [
            OverviewTab(),
            AnimeListTab(),
            MangaListTab(),
            FavoritesTab(),
            StatsTab(),
            ReviewsTab(),
            SubmissionsTab(),
          ],
        ),
      ),
    );
  }
}
