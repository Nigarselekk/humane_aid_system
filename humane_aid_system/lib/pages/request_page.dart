import 'package:flutter/material.dart';

class RequestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Product Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 50.0),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Choose Region',
                border: OutlineInputBorder(),
              ),
              items: [
                DropdownMenuItem(child: Text('Bölge 1'), value: '1'),
                DropdownMenuItem(child: Text('Bölge 2'), value: '2'),
                DropdownMenuItem(child: Text('Bölge 3'), value: '3'),
              ],
              onChanged: (value) {},
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Bildir butonuna tıklanınca yapılacak işlemler
              },
              child: Text('Bildir'),
            ),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Sayfayı kapatarak geri dön
              },
              child: Text('Product Sayfasına Dön'),
            ),
          ],
        ),
      ),
    );
  }
}




  