import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:humane_aid_system/my_service/my_service/constant.dart';
import 'package:humane_aid_system/my_service/my_service/server_info.dart';
import 'package:http/http.dart' as http;
import 'package:humane_aid_system/map/AidPoint.dart';

class HelpPointsListedPage extends StatefulWidget {
  @override
  _HelpPointsPageState createState() => _HelpPointsPageState();
}

class _HelpPointsPageState extends State<HelpPointsListedPage> {
  Future<List<AidPoint>> fetchAidPoints() async {
    try {
      var url = Uri.https(SI.serverName, 
      '${SI.api}/${SI.aidPoint}/get-all');
      final response = await http.get(url, headers: Me.instance.authHeader);

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body)['data'];
        return data.map((item) => AidPoint.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load help points');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help Points'),
      ),
      body: FutureBuilder<List<AidPoint>>(
        future: fetchAidPoints(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No help points found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final helpPoint = snapshot.data![index];
                return ListTile(
                  title: Text(helpPoint.name!),
                  subtitle: Text('ID: ${helpPoint.status}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}






