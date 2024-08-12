import 'dart:convert';

import 'package:humane_aid_system/models/donation_model.dart';

class AidRequest {
  final List<Product> products;
  final String? aidPointName;
  final String? status;

  AidRequest({
    this.products = const [],
    this.aidPointName = "",
    this.status = "",
  });

  factory AidRequest.fromRawJson(String str) =>
      AidRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AidRequest.fromJson(Map<String, dynamic> json) => AidRequest(
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
        aidPointName: json["aidPointName"] ?? "",
        status: json["status"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "aidPointName": aidPointName,
        "status": status,
      };
}
