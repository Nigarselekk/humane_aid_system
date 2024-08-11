import 'dart:convert';

class ProductModel {
    final String? name;
    final String? category;
    final int? id;

    ProductModel({
        this.name = "",
        this.category = "",
        this.id = 0,
    });

    factory ProductModel.fromRawJson(String str) => ProductModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        name: json["name"]??"",
        category: json["category"]??"",
        id: json["id"]??0,
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "category": category,
        "id": id,
    };
}
