import 'package:flutter/material.dart';
import 'login/login_page.dart'; // Ana sayfanın olduğu dosyayı import ettik

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Humane Aid System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme:  TextTheme(
      
        ),
      ),
      debugShowCheckedModeBanner: false,

      home: LoginPage(), // Ana sayfa burada çağrılıyor
    );
  }
}
