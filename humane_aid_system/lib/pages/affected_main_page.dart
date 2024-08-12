import 'package:flutter/material.dart';
import 'package:humane_aid_system/login/new_login_page.dart';
import 'package:humane_aid_system/pages/map_screen.dart';
import 'package:humane_aid_system/pages/products_page.dart';

class AffectedMainPage extends StatefulWidget {
  const AffectedMainPage({super.key});

  @override
  _AffectedMainPageState createState() => _AffectedMainPageState();
}

class _AffectedMainPageState extends State<AffectedMainPage> {
  final TextEditingController _searchController = TextEditingController();

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

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
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _logout();
            },
          ),
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
                  // Perform search operation here
                  String searchTerm = _searchController.text;
                  print('Searched: $searchTerm');
                },
                key: Key('searchBar'),
              ),
            ),
            const Expanded(
              child: MapSample(),
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


  
  void _logout() {
    _navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => LogIn(),
      ),
      (route) => false,
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LogIn(),
      ),
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
  bool showSuggestions = false;

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
          onTap: () {
            setState(() {
              showSuggestions = true;
            });
          },
          onSubmitted: (_) {
            widget.onSubmitted();
          },
        ),
        
      ],
    );
  }
}
