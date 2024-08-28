import 'package:flutter/material.dart';
import 'package:humane_aid_system/models/aidPoint_model.dart';
import 'package:humane_aid_system/models/get_all_product_model.dart';
import 'package:humane_aid_system/services/aid_request_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:humane_aid_system/my/my_service/constant.dart';
import 'package:humane_aid_system/my/my_service/server_info.dart';

class BasketPage extends StatefulWidget {
  final Map<int, GetAllProductModel> basket;

  BasketPage({required this.basket});

  @override
  _BasketPageState createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  List<AidPointModel> aidPoints = [];
  AidPointModel? selectedAidPoint;

  @override
  void initState() {
    super.initState();
    fetchAidPoints();
  }

  Future<void> fetchAidPoints() async {
    try {
      aidPoints = await getAllAidPoints();
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load aid points: $e')),
      );
    }
  }

  void makeRequest(BuildContext context) async {
    if (selectedAidPoint == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select an aid point'),
          duration: Duration(seconds: 5), // Süreyi 5 saniye yapıyoruz
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    List<Map<String, String>> products = widget.basket.values.map((product) {
      return {'name': product.name ?? '', 'category': product.category ?? ''};
    }).toList();

    String aidPointName = selectedAidPoint!.name ?? '';
    List<String> aidPointProducts = selectedAidPoint!.status?.split(' ') ?? [];

    List<String> availableProducts = [];
    List<String> unavailableProducts = [];

    for (var product in widget.basket.values) {
      if (aidPointProducts.contains(product.name)) {
        availableProducts.add(product.name ?? '');
      } else {
        unavailableProducts.add(product.name ?? '');
      }
    }

    String message = '';
    if (availableProducts.isNotEmpty) {
      message +=
          '${availableProducts.join(', ')} are available on help point. . ';
    }
    if (unavailableProducts.isNotEmpty) {
      message +=
          '${unavailableProducts.join(', ')} request has been received. Your request will be met within maximum 2 days..';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(fontSize: 16.0)),
        duration: Duration(seconds: 10), // Mesajın gösterim süresi 10 saniye
        backgroundColor: Colors.blue, 
        behavior: SnackBarBehavior.floating,
      ),
    );

    try {
      var response =
          await AidRequestService.addAidRequest(products, aidPointName);

      if (response.succeeded == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Request successful'),
            duration: Duration(seconds: 5),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Request failed: ${response.message}'),
            duration: Duration(seconds: 5),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Request failed: $e'),
          duration: Duration(seconds: 5),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
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
              itemCount: widget.basket.length,
              itemBuilder: (context, index) {
                int productId = widget.basket.keys.elementAt(index);
                GetAllProductModel product = widget.basket[productId]!;
                return ListTile(
                  title: Text(product.name ?? ''),
                  subtitle: Text(product.category ?? ''),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: aidPoints.isEmpty
                ? CircularProgressIndicator()
                : DropdownButton<AidPointModel>(
                    hint: Text("Choose aid point"),
                    value: selectedAidPoint,
                    onChanged: (newValue) {
                      setState(() {
                        selectedAidPoint = newValue;
                      });
                    },
                    items: aidPoints.map((AidPointModel aidPoint) {
                      return DropdownMenuItem<AidPointModel>(
                        value: aidPoint,
                        child: Text(aidPoint.name ?? ''),
                      );
                    }).toList(),
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
}
