import 'dart:html';

import 'package:flutter/material.dart';
import 'package:humane_aid_system/models/aidPoint_model.dart';
import 'package:humane_aid_system/models/get_all_product_model.dart';
import 'package:humane_aid_system/services/aid_request_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:humane_aid_system/my_service/my_service/constant.dart';
import 'package:humane_aid_system/my_service/my_service/server_info.dart';

class BasketPage extends StatelessWidget {
  final Map<int, GetAllProductModel> basket;

  List<String> categories = [];
  Map<String, List<GetAllProductModel>> products = {};
  List<AidPointModel> aidPoints = [];
  String selectedCategory = '';
  String selectedProduct = '';
  String selectedRegion = '';
  String message = '';

  BasketPage({required this.basket});

  void makeRequest(BuildContext context) async {
    List<Map<String, String>> products = basket.values.map((product) {
      return {'name': product.name ?? '', 'category': product.category ?? ''};
    }).toList();

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

Future<List<AidPointModel>> getAllAidPoints() async {
  var url = Uri.https(
    SI.serverName,
    '${SI.api}/${SI.aidPoint}/get-all',
  );
  final response = await http.get(url, headers: Me.instance.header);
  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((aidPoint) => AidPointModel.fromJson(aidPoint)).toList();
  } else {
    throw Exception('Failed to load aid points');
  }
}
