// import 'dart:convert';
import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
// import 'package:humane_aid_system/map/AidPoint.dart';


import 'package:humane_aid_system/map/AidPoint.dart';

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
  