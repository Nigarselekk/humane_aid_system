import 'dart:convert';

class AidPointModel{
  final String? name;
  final String? aidPointId;
  final String? location;
  final String? status;
  final double? latitude;
  final double? longitude;

  AidPointModel({
      this.name = "",
      this.aidPointId = "",
      this.location = "",
      this.status = "",
      this.latitude = 0.0,
      this.longitude = 0.0,
  });

    factory AidPointModel.fromRawJson(String str) => AidPointModel.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory AidPointModel.fromJson(Map<String, dynamic> json) => AidPointModel(
        name: json["name"]?? "",
        aidPointId: json["aidPointId"]?? "",
        location: json["location"]?? "",
        status: json["status"]?? "",
        latitude: json["latitude"].toDouble()?? 0.0,
        longitude: json["longitude"].toDouble()?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "aidPointId": aidPointId,
        "location": location,
        "status": status,
        "latitude": latitude,
        "longitude": longitude,
      };
}

class AddAidPointResponse {
  final bool succeeded;
  final String? message;
  final List<String>? errors;
  final int? data;

  AddAidPointResponse({
    required this.succeeded,
    this.message,
    this.errors,
    this.data,
  });

  factory AddAidPointResponse.fromJson(Map<String, dynamic> json) => AddAidPointResponse(
        succeeded: json["succeeded"],
        message: json["message"],
        errors: json["errors"] != null ? List<String>.from(json["errors"]) : null,
        data: json["data"],
      );
}
