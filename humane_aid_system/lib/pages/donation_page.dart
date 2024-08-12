import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:humane_aid_system/models/donation_model.dart';
import 'package:humane_aid_system/services/get_all_product_service.dart';
import 'package:humane_aid_system/models/get_all_product_model.dart';
import 'package:humane_aid_system/my_service/my_service/constant.dart';
import 'package:humane_aid_system/my_service/my_service/server_info.dart';
import 'package:humane_aid_system/my_service/my_service_models/base_model.dart';
import 'package:http/http.dart' as http;

class DonationPage extends StatefulWidget {
  const DonationPage({super.key});

  @override
  _DonationPageState createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  String? selectedCategory;
  String? selectedProduct;
  int quantity = 1;
  int selectedProductId = 0;

  Map<String, List<String>> categoryItems = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCategoriesAndProducts();
  }

  Future<void> fetchCategoriesAndProducts() async {
    BaseModel<List<GetAllProductModel>> response =
        await GetAllProductService.getAllProducts();
    if (response.succeeded!) {
      setState(() {
        categoryItems = _groupProductsByCategory(response.data!);
        isLoading = false;
      });
    } else {
      // Handle error case
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load categories and products')),
      );
    }
  }

  Map<String, List<String>> _groupProductsByCategory(
      List<GetAllProductModel> products) {
    Map<String, List<String>> categoryMap = {};
    for (var product in products) {
      if (product.category != null && product.name != null) {
        if (!categoryMap.containsKey(product.category)) {
          categoryMap[product.category!] = [];
        }
        categoryMap[product.category!]!.add(product.name!);
      }
    }
    return categoryMap;
  }

  Future<void> makeDonation() async {
    if (selectedCategory != null && selectedProduct != null && quantity > 0) {
      Map<String, dynamic> donationData = {
        'products': [
          {
            'id':  selectedProductId,
            'name': selectedProduct,
            'category': selectedCategory,
            'amount': quantity,
          }
        ]
      };

      try {
        var url = Uri.https(
          SI.serverName,
          '${SI.api}/${SI.aidOffer}/make-donation',
        );

        var response = await http.post(
          url,
          headers: Me.instance.authHeader,
          body: jsonEncode(donationData),
        );
        log(response.body.toString());
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Your donation has been successfully made.Thanks for your donation.'),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to make donation. Please try again.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        // print('Error making donation: $e');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to make donation: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      // If any required field is missing, show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select category, product, and quantity.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donation Page'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DropdownButton<String>(
                    hint: Text('Select Category'),
                    value: selectedCategory,
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value;
                        selectedProduct = null; // Reset product selection
                      });
                    },
                    items: categoryItems.keys.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                  ),
                  if (selectedCategory != null) ...[
                    SizedBox(height: 16.0),
                    DropdownButton<String>(
                      hint: Text('Select Product'),
                      value: selectedProduct,
                      onChanged: (value) {
                        setState(() {
                          selectedProduct = value;
                        });
                      },
                      items: categoryItems[selectedCategory]!.map((product) {
                        return DropdownMenuItem(
                          value: product,
                          child: Text(product),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Quantity:'),
                        DropdownButton<int>(
                          value: quantity,
                          onChanged: (value) {
                            setState(() {
                              quantity = value!;
                            });
                          },
                          items: List.generate(50, (index) => index + 1)
                              .map((qty) {
                            return DropdownMenuItem(
                              value: qty,
                              child: Text(qty.toString()),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ],
                  Spacer(),
                  ElevatedButton(
                    onPressed:
                        selectedCategory != null && selectedProduct != null
                            ? makeDonation
                            : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: Text('Donate Now'),
                  ),
                ],
              ),
            ),
    );
  }
}
