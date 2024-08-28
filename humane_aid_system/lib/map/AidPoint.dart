import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:humane_aid_system/my/my_service/constant.dart';
import 'package:humane_aid_system/my/my_service/server_info.dart';


class AidPoint {
  final int id;
  final String name;
  final String location;
  final String status;
  final double latitude;
  final double longitude;
  AidPoint({
    required this.id,
    required this.name,
    required this.location,
    required this.status,
    required this.latitude,
    required this.longitude,
  });

  factory AidPoint.fromJson(Map<String, dynamic> json) {
    return AidPoint(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      status: json['status'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
    );
  }
}


Future<List<AidPoint>> fetchAidPoints() async {
  final response = await http.get(Uri.parse('https://humaneaidsystem1.azurewebsites.net/api/AidPoint/get-all'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((json) => AidPoint.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load aid points');
  }
}


Future<List<AidPoint>> getAidPoints() async {
  try {
    var url = Uri.https(SI.serverName, '${SI.api}/${SI.aidPoint}/get-all');
    final response = await http.get(url, headers: Me.instance.authHeader);

    if (response.statusCode == 200) {
      
      print('API Response: ${response.body}');
      
      List<dynamic> data = json.decode(response.body)['data'];
      return data.map((item) {
        print('Parsing item: $item');  
        return AidPoint.fromJson(item);
      }).toList();
    } else {
      throw Exception('Failed to load help points');
    }
  } catch (e) {
    throw Exception('Error fetching aid points: ${e.toString()}');
  }
}


