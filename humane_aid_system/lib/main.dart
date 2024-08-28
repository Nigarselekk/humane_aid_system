import 'package:flutter/material.dart';
import 'package:humane_aid_system/login/login_page.dart';
import 'package:humane_aid_system/map/MapScreen.dart';
import 'package:humane_aid_system/pages/admin_main_page.dart';
import 'package:humane_aid_system/pages/affected_main_page.dart';
import 'package:humane_aid_system/pages/donor_main_page.dart';
import 'package:humane_aid_system/pages/map_screen.dart';
import 'package:humane_aid_system/services/ApiService.dart';

import 'dart:io';

void main() {
  final String backendUrl =
      'https://humaneaidsystem1.azurewebsites.net/swagger';

  final ApiService apiService = ApiService(backendUrl);

  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp(apiService));
}

class MyApp extends StatelessWidget {
  final ApiService apiService;

  MyApp(this.apiService);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Humane Aid System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // textTheme: TextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),

      // home: MapScreenGoogle(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
