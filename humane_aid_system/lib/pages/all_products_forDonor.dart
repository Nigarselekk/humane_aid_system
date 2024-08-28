import 'package:flutter/material.dart';
import 'package:humane_aid_system/models/get_all_product_model.dart';
import 'package:humane_aid_system/services/get_all_product_service.dart';
import 'package:humane_aid_system/my/my_service_models/base_model.dart';

class AllProductsForDonor extends StatefulWidget {
  const AllProductsForDonor({Key? key}) : super(key: key);

  @override
  _AllProductsForDonorState createState() => _AllProductsForDonorState();
}

class _AllProductsForDonorState extends State<AllProductsForDonor>
    with TickerProviderStateMixin {
  final _selectedColor = Color(0xff1a73e8);
  final _unselectedColor = Color(0xff5f6368);

  late Future<BaseModel<List<GetAllProductModel>>> _futureProducts;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _futureProducts = GetAllProductService.getAllProducts();
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
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () {},
          ),
          // IconButton(
          //   icon: Icon(Icons.search, color: Colors.white),
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => RequestPage()),
          //     );
          //   },
          // ),
        ],
      ),
      body: FutureBuilder<BaseModel<List<GetAllProductModel>>>(
        future: _futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData ||
              snapshot.data!.data == null ||
              snapshot.data!.data!.isEmpty) {
            return Center(child: Text('No products available'));
          } else {
            Map<String, List<GetAllProductModel>> categoryProducts = {};
            for (var product in snapshot.data!.data!) {
              final categoryName = product.category ?? 'Unknown';
              categoryProducts.putIfAbsent(categoryName, () => []).add(product);
            }

            List<String> categories = categoryProducts.keys.toList();
            _tabController =
                TabController(length: categories.length, vsync: this);

            return Column(
              children: [
                TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  labelColor: _selectedColor,
                  unselectedLabelColor: _unselectedColor,
                  tabs: categories
                      .map((category) => Tab(text: category))
                      .toList(),
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
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${products[index].name} selected')),
            );
          },
          child: Card(
            child: Center(
              child: Text('${products[index].name}'),
            ),
          ),
        );
      },
    );
  }
}
