
import 'package:flutter/material.dart';

class DonationPage extends StatefulWidget {
  const DonationPage({super.key});


  @override
  _DonationPageState createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  String? selectedCategory;
  String? selectedProduct;
  int quantity = 1;

  final categories = ['Food', 'Clothing', 'Personal Care', 'Electronics'];
  final Map<String, List<String>> categoryItems = {
    'Food': ['Bread', 'Rice', 'Oil'],
    'Clothing': ['Jacket', 'Pants', 'Hat'],
    'Personal Care': ['Soap', 'Shampoo', 'Toothpaste'],
    'Electronics': ['Charger', 'Phone', 'Power Bank'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donation Page'),
      ),
      body: Padding(
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
              items: categories.map((category) {
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
                    items: List.generate(20, (index) => index + 1).map((qty) {
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
              onPressed: selectedCategory != null && selectedProduct != null
                  ? () {
                      // Donation process
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Your request to donate $quantity $selectedProduct has been received.'),
                          backgroundColor: Colors.green,
                        ),
                      );
                      // Other donation transactions can be made here
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: Text('Donation Now'),
            ),
          ],
        ),
      ),
    );
  }
}
