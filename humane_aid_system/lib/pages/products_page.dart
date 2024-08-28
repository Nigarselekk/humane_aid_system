import 'package:flutter/material.dart';
import 'package:humane_aid_system/models/get_all_product_model.dart';
import 'package:humane_aid_system/pages/request_page.dart';
import 'package:humane_aid_system/pages/basket_page.dart';
import 'package:humane_aid_system/services/get_all_product_service.dart';
import 'package:humane_aid_system/my/my_service_models/base_model.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> with TickerProviderStateMixin {
  final _selectedColor = Color(0xff1a73e8);
  final _unselectedColor = Color(0xff5f6368);

  late Future<BaseModel<List<GetAllProductModel>>> _futureProducts;
  late TabController _tabController;
  Set<GetAllProductModel> basket = {}; 

  @override
  void initState() {
    super.initState();
    _futureProducts = GetAllProductService.getAllProducts();
  }

  void _addToBasket(GetAllProductModel product) {
    setState(() {
      basket.add(product); //
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${product.name} added')),
    );
  }

  void _removeFromBasket(GetAllProductModel product) {
    setState(() {
      basket.remove(product); // 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _selectedColor,
        title: Text(
          "Products",
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BasketPage(basket: Map.fromIterable(basket.toList(), key: (item) => item.id, value: (item) => item))),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RequestPage()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<BaseModel<List<GetAllProductModel>>>(
        future: _futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.data == null || snapshot.data!.data!.isEmpty) {
            return Center(child: Text('No products available'));
          } else {
            Map<String, List<GetAllProductModel>> categoryProducts = {};
            for (var product in snapshot.data!.data!) {
              final categoryName = product.category ?? 'Unknown';
              categoryProducts.putIfAbsent(categoryName, () => []).add(product);
            }

            List<String> categories = categoryProducts.keys.toList();
            _tabController = TabController(length: categories.length, vsync: this);

            return Column(
              children: [
                TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  labelColor: _selectedColor,
                  unselectedLabelColor: _unselectedColor,
                  tabs: categories.map((category) => Tab(text: category)).toList(),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: categories.map((category) {
                      return _buildGrid(categoryProducts[category]!);
                    }).toList(),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildGrid(List<GetAllProductModel> products) {
    return GridView.builder(
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        return Card(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${products[index].name}'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: basket.contains(products[index]) ? () => _removeFromBasket(products[index]) : null,
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () => _addToBasket(products[index]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
