import 'package:flutter/material.dart';
import 'package:humane_aid_system/models/aidPoint_model.dart';
import 'package:humane_aid_system/services/aidPoint_service.dart';
import 'package:humane_aid_system/my/my_service_models/base_model.dart';

class AddAidPointPage extends StatefulWidget {
  @override
  _AddAidPointPageState createState() => _AddAidPointPageState();
}

class _AddAidPointPageState extends State<AddAidPointPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  // final _aidPointIdController = TextEditingController();
  final _locationController = TextEditingController();
  final _statusController = TextEditingController();
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    // _aidPointIdController.dispose();
    _locationController.dispose();
    _statusController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final aidPoint = AidPointModel(
        name: _nameController.text,
        // aidPointId: _aidPointIdController.text,
        location: _locationController.text,
        status: _statusController.text,
        latitude: double.parse(_latitudeController.text),
        longitude: double.parse(_longitudeController.text),
      );

      try {
        BaseModel<AidPointModel> response = await AidPointService.addAidPoint(
          aidPoint.name ?? "",
          // aidPoint.aidPointId??"",
          aidPoint.location ?? "",
          aidPoint.status ?? "",
          aidPoint.latitude ?? 0.0,
          aidPoint.longitude ?? 0.0,
        );
        if (response.succeeded!) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Aid Point added successfully!')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to add Aid Point')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Aid Point'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              // TextFormField(
              //   controller: _aidPointIdController,
              //   decoration: InputDecoration(labelText: 'Aid Point ID'),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter an Aid Point ID';
              //     }
              //     return null;
              //   },
              // ),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(labelText: 'Location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a location';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _statusController,
                decoration: InputDecoration(labelText: 'Status'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a status';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _latitudeController,
                decoration: InputDecoration(labelText: 'Latitude'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a latitude';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _longitudeController,
                decoration: InputDecoration(labelText: 'Longitude'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a longitude';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Add Aid Point'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
