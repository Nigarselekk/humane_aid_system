import 'package:flutter/material.dart';
import 'package:humane_aid_system/pages/request_page.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _selectedColor = Color(0xff1a73e8);
  final _unselectedColor = Color(0xff5f6368);
  final _tabs = [
    Tab(text: 'Product1'),
    Tab(text: 'Product2'),
    Tab(text: 'Product3'),
  ];

  final _iconTabs = [
    Tab(icon: Icon(Icons.home)),
    Tab(icon: Icon(Icons.search)),
    Tab(icon: Icon(Icons.settings)),
  ];

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  bool _isMouseOver = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _selectedColor,
        title: Text(
          "Products",
          style: TextStyle(color: Colors.white), // Metin rengini beyaz yap
        ),
        actions: [
          // Container(
          //   child: Padding(
          //     padding: const EdgeInsets.all(10.0),
          //     child: IconButton(
          //       icon: Icon(Icons.add),
          //       color: Colors.white,
          //       onPressed: () {
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(builder: (context) => RequestPage()),
          //         );
          //       },
          //     ),
          //   ),
          // ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TabBar(
              controller: _tabController,
              tabs: _tabs,
              labelColor: _selectedColor,
              indicatorColor: _selectedColor,
              unselectedLabelColor: _unselectedColor,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildGrid('Product1'),
                  _buildGrid('Product2'),
                  _buildGrid('Product3'),
                ],
              ),
            ),
            // Container(
            //   color: Colors.grey[100],
            //   child: TextButton(
            //     onPressed: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(builder: (context) => RequestPage()),
            //       );
            //     },
            //     child: Text('I couldn \'t find the product I needed.', style: TextStyle(color: Colors.black),
            //   ),
            // ),
            // ),
          ],
        ),
      ),

      //   bottomNavigationBar: Container(
      //     color: Colors.grey,
      //     child: ElevatedButton(
      //       onPressed: () {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(builder: (context) => RequestPage()),
      //         );
      //       },
      //       child: Text(
      //         'I couldn \'t find the product I needed.',
      //         style: TextStyle(color: Colors.black),
      //       ),
      //     ),
      // ),
    );
  }

  Widget _buildGrid(String tabName) {
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(
        10,
        (index) {
          if (index == 9) {
            // Son öğeyi kontrol ediyoruz
            return Expanded(
                child:
                    _buildLastItem()); // Son öğeyi oluşturmak için ayrı bir fonksiyon çağırıyoruz

          } else {
            return Card(
              child: Center(
                child: Text('$tabName - Item $index'),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildLastItem() {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RequestPage()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "I couldn't find the product I needed.",
                style: TextStyle(color: Colors.red), // Metin rengini kırmızı yap
              ),
            ),
          ),

          SizedBox(height: 8.0), 
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RequestPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
