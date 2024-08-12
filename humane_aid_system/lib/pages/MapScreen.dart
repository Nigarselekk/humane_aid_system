import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    _fetchAidPoints();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> _fetchAidPoints() async {
    final response = await http.get(Uri.parse('https://humaneaidsystem1.azurewebsites.net/swagger/api/aidpoint/route'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        markers = data.map((aidPoint) {
          return Marker(
            markerId: MarkerId(aidPoint['id'].toString()),
            position: LatLng(aidPoint['latitude'], aidPoint['longitude']),
            infoWindow: InfoWindow(
              title: aidPoint['name'],
              snippet: aidPoint['location'],
            ),
          );
        }).toSet();
      });
    } else {
      throw Exception('Failed to load aid points');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aid Points Map'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(39.9334, 32.8597), // Ankara, Türkiye koordinatları
          zoom: 10,
        ),
        markers: markers,
      ),
    );
  }
}