import 'package:flutter/material.dart';
import 'package:humane_aid_system/pages/needs_page.dart';

class MainPage extends StatefulWidget { @override
  _MainPageState createState() => _MainPageState();
}


class _MainPageState extends State<MainPage> {
  final TextEditingController _searchController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchBar(
              controller: _searchController,
              onSubmitted: () {
                // Burada arama işlemini gerçekleştirin
                String searchTerm = _searchController.text;
                print('Aranan: $searchTerm');
            
              }, key: Key('searchBar'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Expanded(
              child: Placeholder(), // Buraya harita gelecek
            ),
          ),
        
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
              
                // Butona tıklandığında arama işlemini gerçekleştirin
                // String searchTerm = _searchController.text;
                // print('Aranan: $searchTerm');

                // Navigator.pushNamed(context, '/search', arguments: _searchController.text);
              
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage()),
                      );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Butonun arka plan rengi
                padding: EdgeInsets.symmetric(vertical: 20.0), // Buton içeriğinin yüksekliği
                textStyle: TextStyle(fontSize: 20.0, color: Colors.white), // Buton içeriğinin metin boyutu
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0), // Butonun kenar yuvarlama miktarı
                ),
              ),
              child: Text('What do you need?'),
            ),
          ),
        ],
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
  List<String> suggestions = ['Item 1', 'Item 2', 'Item 3', 'Item 4']; // Örnek öneri listesi
  bool showSuggestions = false; // Önerilerin görünürlüğünü kontrol etmek için bir bayrak

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
              showSuggestions = true; // Arama çubuğuna tıklandığında önerileri göster
            });
          },
          onSubmitted: (_) {
            widget.onSubmitted();
          },
        ),
        if (showSuggestions) // Eğer öneriler gösterilmesi gerekiyorsa
          Container(
            height: 150, // Öneri listesi için bir yükseklik belirtin
            decoration: BoxDecoration(
              color: Colors.grey[200], // Öneri listesi arka plan rengi
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(10.0)), // Kenar yuvarlama
            ),
            child: ListView.builder(
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(suggestions[index]),
                  onTap: () {
                    setState(() {
                      widget.controller.text = suggestions[index]; // Seçilen öneriyi arama çubuğuna ekleyin
                      showSuggestions = false; // Önerileri gizle
                    });
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}




