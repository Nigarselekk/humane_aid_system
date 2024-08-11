import 'dart:convert';

class SearchModel {
    final bool? succeeded;
    final dynamic message;
    final dynamic errors;
    final List<dynamic>? data;

    SearchModel({
        this.succeeded = false,
        this.message = "",
        this.errors = "",
        this.data = const [],
    });

    factory SearchModel.fromRawJson(String str) => SearchModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        succeeded: json["succeeded"]??false,
        message: json["message"]??"",
        errors: json["errors"]??"",
        data: json["data"] == null ? [] : List<dynamic>.from(json["data"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "succeeded": succeeded,
        "message": message,
        "errors": errors,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
    };
}
