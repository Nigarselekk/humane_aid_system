import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:humane_aid_system/map/AidPoint.dart';
// import 'dart:convert';
import 'dart:convert';

import 'package:http/http.dart' as http;

class MapScreenGoogle extends StatefulWidget {
  @override
  _MapScreenGoogleState createState() => _MapScreenGoogleState();
}

class _MapScreenGoogleState extends State<MapScreenGoogle> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(36.892803, 30.663757);
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _loadAidPoints();
  }

  Future<void> _loadAidPoints() async {
    try {
      List<AidPoint> aidPoints = await fetchAidPoints();
      setState(() {
        _markers = aidPoints.map((aidPoint) {
          return Marker(
            markerId: MarkerId(aidPoint.id.toString()),
            position: LatLng(aidPoint.latitude, aidPoint.longitude),
            infoWindow: InfoWindow(
              title: aidPoint.name,
              snippet: aidPoint.status,
            ),
          );
        }).toSet();
      });
    } catch (e) {
      print('Error loading aid points: $e');
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //     // title: Text('Aid Points Map'),
      //     ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
        markers: _markers,
      ),
    );
  }
}

Future<List<AidPoint>> getLocations() async {
  try {
    var url = 'https://humaneaidsystem1.azurewebsites.net/swagger/';
    final resp = await http.get(url as Uri);
    final responsebody = jsonDecode(resp.body);
    return responsebody; //this return a list
  } catch (e) {
    return [];
  }
}

List<Marker> allMarkers = [];

loadLocations() async {
  List<AidPoint> locations;
  locations = [];
  locations = await getLocations(); //we store the response in a list
  for (var i = 0; i < locations.length; i++) {
    LatLng latlng;
    latlng = LatLng(
      double.parse(locations[i].latitude as String),
      double.parse(locations[i].longitude as String),
    );
    allMarkers.add(
      Marker(
        markerId: MarkerId(locations[i].location as String),
        position: latlng,
      ),
    );
  }
  // setState(() {});
}
