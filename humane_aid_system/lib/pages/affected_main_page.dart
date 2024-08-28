import 'package:flutter/material.dart';
import 'package:humane_aid_system/login/new_login_page.dart';
import 'package:humane_aid_system/models/aidPoint_model.dart';
import 'package:humane_aid_system/pages/products_page.dart';
import 'package:humane_aid_system/services/aidPoint_service.dart';
import 'package:http/http.dart' as http;
import 'package:humane_aid_system/map/MapScreen.dart' as FirstMapScreen;


class AffectedMainPage extends StatefulWidget {
  const AffectedMainPage({Key? key}) : super(key: key);

  @override
  _AffectedMainPageState createState() => _AffectedMainPageState();
}

class _AffectedMainPageState extends State<AffectedMainPage> {
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  List<AidPointModel> _searchResults = [];
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      onGenerateRoute: (settings) => MaterialPageRoute(
        builder: (context) => _buildMainPage(),
      ),
    );
  }

  Widget _buildMainPage() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page'),
        actions: [
          // IconButton(
          //   icon: Icon(Icons.logout),
          //   onPressed: () {
          //     _logout();
          //   },
          // ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchBar(
                controller: _searchController,
                onSubmitted: () {
                  String searchTerm = _searchController.text;
                  _searchAidPoints(searchTerm);
                },
                key: Key('searchBar'),
              ),
            ),
            if (_isSearching)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ElevatedButton(
                  onPressed: _clearSearch,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 208, 211, 220),
                    textStyle: TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                  child: Text('Back'),
                ),
              ),
            Expanded(
              child: _isSearching
                  ? SearchResultsList(searchResults: _searchResults)
                  : FirstMapScreen.MapScreenGoogle(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  _navigatorKey.currentState?.push(MaterialPageRoute(
                    builder: (context) => ProductPage(),
                  ));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  textStyle: TextStyle(fontSize: 20.0, color: Colors.white),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text(
                  'What do you need?',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _searchAidPoints(String keyword) async {
    try {
      Map<String, dynamic> searchResult = await AidPointService.searchAidPoints(keyword);
      if (searchResult.containsKey('data')) {
        List<AidPointModel> searchResults = (searchResult['data'] as List)
            .map((item) => AidPointModel.fromJson(item))
            .toList();
        setState(() {
          _searchResults = searchResults;
          _isSearching = true;
        });
        if (searchResults.isNotEmpty) {
          print('Search results: $searchResults');
        } else {
          print('No search results found');
        }
      } else {
        throw Exception('No data found in search result');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to search aid points: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _clearSearch() {
    setState(() {
      _searchResults = [];
      _isSearching = false;
    });
  }

  void _logout() {
    _navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => LogIn(),
      ),
      (route) => false,
    );
  }
}

class SearchBar extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSubmitted;

  const SearchBar({
    required Key key,
    required this.controller,
    required this.onSubmitted,
  }) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: 'Search...',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(),
          ),
          onSubmitted: (_) {
            widget.onSubmitted();
          },
        ),
      ],
    );
  }
}

class SearchResultsList extends StatelessWidget {
  final List<AidPointModel> searchResults;

  const SearchResultsList({required this.searchResults});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final aidPoint = searchResults[index];
        return ListTile(
          title: Text(aidPoint.name ?? 'No Name'),
          subtitle: Text(aidPoint.location ?? 'No Location'),
        );
      },
    );
  }
}
