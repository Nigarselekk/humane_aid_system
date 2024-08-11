import 'dart:convert';

class DonationModel {
    final String? category;
    final List<Product>? products;

    DonationModel({
        this.category = "",
        this.products = const [],
    });

    factory DonationModel.fromRawJson(String str) => DonationModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DonationModel.fromJson(Map<String, dynamic> json) => DonationModel(
        category: json["category"]??"",
        products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "category": category,
        "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
    };
}

class Product {
    final String? name;
    final String? category;
    final int? amount;

    Product({
        this.name = "",
        this.category = "",
        this.amount = 0,
    });

    factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        name: json["name"]??"",
        category: json["category"]??"",
        amount: json["amount"]??0,
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "category": category,
        "amount": amount,
    };
}
