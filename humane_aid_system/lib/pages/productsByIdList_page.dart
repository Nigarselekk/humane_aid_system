import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:humane_aid_system/models/product_model.dart';
import 'package:humane_aid_system/my/my_service/constant.dart';
import 'package:humane_aid_system/my/my_service/server_info.dart';
import 'package:http/http.dart' as http;


class ProductsByIdListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductsByIdListPage> {
  Future<List<ProductModel>> fetchProducts() async {
    try {
      var url = Uri.https(SI.serverName, '${SI.api}/Product/get-all');
      final response = await http.get(url, headers: Me.instance.authHeader);

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body)['data'];
        return data.map((item) => ProductModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Map<String, List<ProductModel>> groupByCategory(List<ProductModel> products) {
    Map<String, List<ProductModel>> groupedProducts = {};
    for (var product in products) {
      if (!groupedProducts.containsKey(product.category)) {
        groupedProducts[product.category!] = [];
      }
      groupedProducts[product.category]!.add(product);
    }
    return groupedProducts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: FutureBuilder<List<ProductModel>>(
        future: fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No products found'));
          } else {
            Map<String, List<ProductModel>> groupedProducts = groupByCategory(snapshot.data!);
            return ListView(
              children: groupedProducts.entries.map((entry) {
                return ExpansionTile(
                  title: Text(entry.key),
                  children: entry.value.map((product) {
                    return ListTile(
                      title: Text(product.name!),
                      subtitle: Text('ID: ${product.id}'),
                    );
                  }).toList(),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}

