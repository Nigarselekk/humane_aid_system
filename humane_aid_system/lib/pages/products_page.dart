import 'package:flutter/material.dart';
import 'package:humane_aid_system/models/get_all_product_model.dart';
import 'package:humane_aid_system/services/get_all_product_service.dart';
import 'package:humane_aid_system/my_service/my_service_models%20copy/base_model.dart';

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

  @override
  void initState() {
    _tabController = TabController(
        length: 1, vsync: this); // Only one tab for all categories
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
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
      ),
      body: FutureBuilder(
        future: GetAllProductService.getAllProducts(),
        builder: (context,
            AsyncSnapshot<BaseModel<List<GetAllProductModel>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData ||
              snapshot.data!.data == null ||
              snapshot.data!.data!.isEmpty) {
            return Center(child: Text('No products available'));
          } else {
            List<GetAllProductModel> products = snapshot.data!.data!;
            return _buildGrid(products);
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
              child:
                  Text('${products[index].category} - ${products[index].name}'),
            ),
          ),
        );
      },
    );
  }
}
