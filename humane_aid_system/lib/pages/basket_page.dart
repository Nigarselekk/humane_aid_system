import 'package:flutter/material.dart';
import 'package:humane_aid_system/models/get_all_product_model.dart';
import 'package:humane_aid_system/services/aid_request_service.dart'; // Yeni servis importu

class BasketPage extends StatelessWidget {
  final Map<int, GetAllProductModel> basket;

  BasketPage({required this.basket});

  void makeRequest(BuildContext context) async {
  
    List<Map<String, String>> products = basket.values.map((product) {
      return {'name': product.name ?? '', 'category': product.category ?? ''};
    }).toList();

    // Aid Point Name (örneğin, "aidpoint1")
    String aidPointName = "aidpoint1";

    try {
      var response =
          await AidRequestService.addAidRequest(products, aidPointName);

      
      if (response.succeeded!) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Request successful')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Request failed: ${response.message}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Request failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Basket"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: basket.length,
              itemBuilder: (context, index) {
                int productId = basket.keys.elementAt(index);
                GetAllProductModel product = basket[productId]!;
                return ListTile(
                  title: Text(product.name ?? ''),
                  subtitle: Text(product.category ?? ''),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () => makeRequest(context),
              child: Text('Make a Request'),
            ),
          ),
        ],
      ),
    );
  }
}
