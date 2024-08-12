import 'dart:convert';

class GetAllProductModel {
  final int? id;
  final String? name;
  final String? category;

  GetAllProductModel({
    this.id,
    this.name,
    this.category,
  });

  factory GetAllProductModel.fromRawJson(String str) => GetAllProductModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetAllProductModel.fromJson(Map<String, dynamic> json) => GetAllProductModel(
        id: json["id"],
        name: json["name"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category": category,
      };
}





