import 'package:flutter/material.dart';
import 'package:humane_aid_system/models/get_all_product_model.dart';
import 'package:humane_aid_system/models/aidPoint_model.dart';
import 'package:humane_aid_system/services/aidPoint_service.dart';
import 'package:humane_aid_system/services/get_all_product_service.dart';
import 'package:humane_aid_system/my_service/my_service_models/base_model.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({Key? key}) : super(key: key);

  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  final TextEditingController _productNameController = TextEditingController();
  String? _selectedRegion;
  String? _selectedCategory;
  String? _selectedProduct;
  String? _selectedAidPoint;

  late Future<BaseModel<List<GetAllProductModel>>> _futureProducts =
      GetAllProductService.getAllProducts();

  late Future<BaseModel<List<AidPointModel>>> _futureAidPoints;

  @override
  void initState() {
    super.initState();
    _futureProducts = GetAllProductService.getAllProducts();
    _futureAidPoints = AidPointService.getAidPoints();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: FutureBuilder<BaseModel<List<GetAllProductModel>>>(
          future: _futureProducts,
          builder: (context, productSnapshot) {
            if (productSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (productSnapshot.hasError) {
              return Center(child: Text('Error: ${productSnapshot.error}'));
            } else if (!productSnapshot.hasData ||
                productSnapshot.data!.data == null ||
                productSnapshot.data!.data!.isEmpty) {
              return Center(child: Text('No products available'));
            } else {
              Map<String, List<GetAllProductModel>> categoryProducts = {};
              for (var product in productSnapshot.data!.data!) {
                final categoryName = product.category ?? 'Unknown';
                categoryProducts
                    .putIfAbsent(categoryName, () => [])
                    .add(product);
              }

              List<String> categories = categoryProducts.keys.toList();

              return FutureBuilder<BaseModel<List<AidPointModel>>>(
                future: _futureAidPoints,
                builder: (context, aidPointSnapshot) {
                  if (aidPointSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (aidPointSnapshot.hasError) {
                    return Center(
                        child: Text('Error: ${aidPointSnapshot.error}'));
                  } else if (!aidPointSnapshot.hasData ||
                      aidPointSnapshot.data!.data == null ||
                      aidPointSnapshot.data!.data!.isEmpty) {
                    return Center(child: Text('No aid points available'));
                  } else {
                    List<AidPointModel> aidPoints =
                        aidPointSnapshot.data!.data!;

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: 'Choose Category',
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          ),
                          value: _selectedCategory,
                          items: categories.map((category) {
                            return DropdownMenuItem(
                                child: Text(category), value: category);
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedCategory = value;
                              _selectedProduct = null;
                            });
                          },
                        ),
                        SizedBox(height: 8.0),
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: 'Choose Product',
                            border: OutlineInputBorder(),
                          ),
                          value: _selectedProduct,
                          items: (_selectedCategory != null
                                  ? categoryProducts[_selectedCategory!] ?? []
                                  : <GetAllProductModel>[])
                              .map<DropdownMenuItem<String>>((product) {
                            return DropdownMenuItem<String>(
                              child: Text(product.name!),
                              value: product.name,
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedProduct = value;
                            });
                          },
                        ),
                        SizedBox(height: 8.0),
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: 'Choose Aid Point',
                            border: OutlineInputBorder(),
                          ),
                          value: _selectedAidPoint,
                          items: aidPoints
                              .map<DropdownMenuItem<String>>((aidPoint) {
                            return DropdownMenuItem<String>(
                              child: Text(aidPoint.name!),
                              value: aidPoint.name,
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedAidPoint = value;
                            });
                          },
                        ),
                        SizedBox(height: 8.0),
                        ElevatedButton(
                          onPressed: _submitRequest,
                          child: Text('Submit'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: EdgeInsets.symmetric(vertical: 12),
                            textStyle: TextStyle(fontSize: 18),
                          ),
                        ),
                        SizedBox(height: 5.0),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Go back to Product Page
                          },
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _productNameController.dispose();
    super.dispose();
  }

  void _submitRequest() {
    if (_selectedProduct == null ||
        _selectedCategory == null ||
        _selectedAidPoint == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields.'),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Your request has been submitted.'),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.green,
        ),
      );
      // Additional logic for request submission can be added here
    }
  }
}
