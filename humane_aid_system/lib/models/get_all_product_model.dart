import 'dart:convert';

class GetAllProductModel {
    final int? id;
    final Name? name;
    final Category? category;

    GetAllProductModel({
        this.id = 0,
        this.name = Name.LAMP,
        this.category = Category.C1,
    });

    factory GetAllProductModel.fromRawJson(String str) => GetAllProductModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GetAllProductModel.fromJson(Map<String, dynamic> json) => GetAllProductModel(
        id: json["id"] ?? 0,
        name: nameValues.map[json["name"]]!??Name.LAMP,
        category: categoryValues.map[json["category"]]!??Category.C1,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameValues.reverse[name],
        "category": categoryValues.reverse[category],
    };
}

enum Category {
    C1,
    SHELTER,
    STRING
}

final categoryValues = EnumValues({
    "C1": Category.C1 ,
    "shelter": Category.SHELTER,
    "string": Category.STRING
});

enum Name {
    LAMP,
    P1,
    STRING
}

final nameValues = EnumValues({
    "lamp": Name.LAMP,
    "P1": Name.P1,
    "string": Name.STRING
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}