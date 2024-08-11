import 'package:flutter/material.dart';

class RequestPage extends StatefulWidget {
  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  final TextEditingController _productNameController = TextEditingController();
  String? _selectedRegion;

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
              controller: _productNameController,
              decoration: InputDecoration(
                labelText: 'Product Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Choose Region',
                border: OutlineInputBorder(),
              ),
              value: _selectedRegion,
              items: [
                DropdownMenuItem(child: Text('Region 1'), value: '1'),
                DropdownMenuItem(child: Text('Region 2'), value: '2'),
                DropdownMenuItem(child: Text('Region 3'), value: '3'),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedRegion = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Check if product name or region is empty
                if (_productNameController.text.isEmpty ||
                    _selectedRegion == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please fill in all fields.'),
                      duration: Duration(seconds: 3),
                    ),
                  );
                } else {
                  // Proceed with the request submission logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Your request has been submitted.'),
                      duration: Duration(seconds: 3),
                      backgroundColor: Colors.green,
                    ),
                  );
                  // You can add additional logic here to handle the request submission
                }
              },
              child: Text('Bildir'),
            ),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Sayfayı kapatarak geri dön
              },
              child: Text('Go back Product Page'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _productNameController.dispose();
    super.dispose();
  }
}
