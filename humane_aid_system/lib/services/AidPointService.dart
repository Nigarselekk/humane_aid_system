import 'dart:convert';
import 'package:http/http.dart' as http;

class AidPointService {
  final String baseUrl;
  final String apiKey;

  AidPointService({required this.baseUrl, required this.apiKey});

  Future<List<AidPoint>> getAidPoints() async {
    final response = await http.get(Uri.parse('$baseUrl/api/AidPoint/route'));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<AidPoint> aidPoints = body.map((dynamic item) => AidPoint.fromJson(item)).toList();
      return aidPoints;
    } else {
      throw Exception('Failed to load aid points');
    }
  }

  Future<String> getRoute(AidPoint origin, AidPoint destination) async {
    final response = await http.get(Uri.parse('$baseUrl/api/AidPoint/route?originLat=${origin.latitude}&originLng=${origin.longitude}&destinationLat=${destination.latitude}&destinationLng=${destination.longitude}'));

    if (response.statusCode == 200) {
      return json.decode(response.body)['route'];
    } else {
      throw Exception('Failed to load route');
    }
  }
}

class AidPoint {
  final double latitude;
  final double longitude;
  final String name;

  AidPoint({required this.latitude, required this.longitude, required this.name});

  factory AidPoint.fromJson(Map<String, dynamic> json) {
    return AidPoint(
      latitude: json['latitude'],
      longitude: json['longitude'],
      name: json['name'],
    );
  }
}
