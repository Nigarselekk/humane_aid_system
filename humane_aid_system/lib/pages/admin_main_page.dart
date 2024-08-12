import 'dart:async';
import 'package:flutter/material.dart';
import 'package:humane_aid_system/models/aidPoint_model.dart';
import 'package:humane_aid_system/models/aidRequest_model.dart';
import 'package:humane_aid_system/models/product_model.dart';
import 'package:humane_aid_system/pages/map_screen.dart';
import 'package:http/http.dart' as http;
import 'package:humane_aid_system/my_service/my_service/constant.dart';
import 'package:humane_aid_system/my_service/my_service/server_info.dart';
import 'dart:convert';

import 'package:humane_aid_system/my_service/my_service_models/base_model.dart';

class AdminMainPage extends StatefulWidget {
  const AdminMainPage({super.key});

  @override
  _AdminMainPageState createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage> {


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Expanded(
            child: MapSample(),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  text: 'Add Help Point',
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => _buildAddHelpPoint(context),
                    );
                  },
                ),
                      CustomButton(
                  text: 'Update Status of Help Point',
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => _buildUpdateStatusHelpPoint(context),
                    );
                  },
                ),
                CustomButton(
                  text: 'Remove Help Point',
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => _buildRemoveHelpPoint(context),
                    );
                  },
                ),
                CustomButton(
                  text: 'Create Product',
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => _buildCreateProduct(context),
                    );
                  },
                ),
                CustomButton(
                  text: 'Delete Product',
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => _buildDeleteProduct(context),
                    );
                  },
                ),
                CustomButton(
                  text: 'Update Status of Affected Aid Request',
                  onPressed: () {
                    // showDialog(
                    //   context: context,
                    //    builder: (_) => _buildUpdateStatusAffectedRequest(context),
                    // );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

//---------------------------------Create Product-----------------------------------------------

  Widget _buildCreateProduct(BuildContext context) {
    final _nameController = TextEditingController();
    final _categoryController = TextEditingController();

    return AlertDialog(
      title: Text('Create Product'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Product Name'),
          ),
          TextField(
            controller: _categoryController,
            decoration: InputDecoration(labelText: 'Category'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            final name = _nameController.text;
            final category = _categoryController.text;

            final response = await createProduct(name, category);

            if (response.succeeded!) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      'Product created successfully! ID: ${response.data!.id}'),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pop(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Failed to create product.'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: Text('Create'),
        ),
      ],
    );
  }


  Future<BaseModel<ProductModel>> createProduct(
    String name,
    String category,
  ) async {
    try {
      var url = Uri.https(
        SI.serverName,
        '${SI.api}/${SI.product}/create',
      );
      final http.Response response = await http
          .post(
            url,
            headers: Me.instance.header,
            body: jsonEncode(<String, dynamic>{
              "name": name,
              "category": category,
            }),
          )
          .timeout(const Duration(seconds: 60));
      switch (response.statusCode) {
        case 200:
          return BaseModel<ProductModel>.fromJson(
            json: json.decode(response.body),
            d: ProductModel.fromJson(json.decode(response.body)["data"]) ??
                ProductModel(),
          );
        default:
          return BaseModel.fromJson(json: json.decode(response.body));
      }
    } on TimeoutException {
      throw Exception("Timeout... ");
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
//------------------------------------------------------------------------------------------

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}


//-------------------------------------------------------------------------------------------

//---------------------------------Delete Product-----------------------------------------------  

Widget _buildDeleteProduct(BuildContext context) {
    final _idController = TextEditingController();

    return AlertDialog(
      title: Text('Delete Product'),
      content: TextField(
        controller: _idController,
        decoration: InputDecoration(labelText: 'Product ID'),
        keyboardType: TextInputType.number,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            final id = int.tryParse(_idController.text);

            if (id == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Invalid Product ID'),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            }

            final response = await deleteProduct(id);

            if (response.succeeded == true) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Product deleted successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pop(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Failed to delete product: ${response.message}'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: Text('Delete'),
        ),
      ],
    );
  }



  Future<BaseModel<ProductModel>> deleteProduct(
    int id,
    
  ) async {
    try {
      var url = Uri.https(
        SI.serverName,
        '${SI.api}/${SI.product}/delete',
      );
      final http.Response response = await http
          .post(
            url,
            headers: Me.instance.header,  
            body: jsonEncode(<String, dynamic>{
              "id": id,
            }),
          )
          .timeout(const Duration(seconds: 60));
      switch (response.statusCode) {
        case 200:
          return BaseModel<ProductModel>.fromJson(
            json: json.decode(response.body),
              d: ProductModel.fromJson(json.decode(response.body)["data"]) ??
                ProductModel(),
          );
        default:
          return BaseModel.fromJson(json: json.decode(response.body));
      }
    } on TimeoutException {
      throw Exception("Timeout... ");
    } catch (e) {
      throw Exception(e.toString());
    }
  }




//-------------------------------------------------------------------------------------------

//---------------------------------Update Status of Help Point-----------------------------------------------

    Widget _buildUpdateStatusHelpPoint(BuildContext context) {
    final _idController = TextEditingController();
    final _statusController = TextEditingController();

    return AlertDialog(
      title: Text('Update Status of Help Point'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _idController,
            decoration: InputDecoration(labelText: 'Aid Point ID'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: _statusController,
            decoration: InputDecoration(labelText: 'New Status'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            final id = int.tryParse(_idController.text);
            final status = _statusController.text;

            if (id == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Invalid Aid Point ID'),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            }

            final response = await updateAidPointStatus(id, status);

            if (response.succeeded == true) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Aid Point status updated successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pop(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Failed to update aid point status: ${response.message}'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: Text('Update'),
        ),
      ],
    );
  }

  Future<BaseModel<AidPointModel>> updateAidPointStatus(
    int id,
    String status,
  ) async {
    try {
      var url = Uri.https(
        SI.serverName,
        '${SI.api}/${SI.aidPoint}/update-status',
      );
      final http.Response response = await http
          .put(
            url,
            headers: Me.instance.header,
            body: jsonEncode(<String, dynamic>{
              "id": id,
              "status": status,
            }),
          )
          .timeout(const Duration(seconds: 60));
      switch (response.statusCode) {
        case 200:
          return BaseModel<AidPointModel>.fromJson(
            json: json.decode(response.body),
            d: AidPointModel.fromJson(json.decode(response.body)["data"]) ??
                AidPointModel(),
          );
        default:
          return BaseModel.fromJson(json: json.decode(response.body));
      }
    } on TimeoutException {
      throw Exception("Timeout... ");
    } catch (e) {
      throw Exception(e.toString());
    }
  }

//-------------------------------------------------------------------------------------------
//---------------------------------Remove Help Point-----------------------------------------------


  Widget _buildRemoveHelpPoint(BuildContext context) {
    final _idController = TextEditingController();

    return AlertDialog(
      title: Text('Remove Help Point'),
      content: TextField(
        controller: _idController,
        decoration: InputDecoration(labelText: 'Help Point ID'),
        keyboardType: TextInputType.number,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            final id = int.tryParse(_idController.text);

            if (id == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Invalid Help Point ID'),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            }

            final response = await removeHelpPoint(id);

            if (response.succeeded == true) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Help Point removed successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pop(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Failed to remove help point: ${response.message}'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: Text('Remove'),
        ),
      ],
    );
  }



  Future<BaseModel<AidPointModel>> removeHelpPoint(
    int id,
  ) async {
    try {
      var url = Uri.https(
        SI.serverName,
        '${SI.api}/${SI.aidPoint}/remove/${id}',
      );
      final http.Response response = await http
          .post(
            url,
            headers: Me.instance.header,
            body: jsonEncode(<String, dynamic>{
              "id": id,
            }),
          )
          .timeout(const Duration(seconds: 60));
      switch (response.statusCode) {
        case 200:
          return BaseModel<AidPointModel>.fromJson(
            json: json.decode(response.body),
            d: AidPointModel.fromJson(json.decode(response.body)["data"]) ??
                AidPointModel(),
          );
        default:
          return BaseModel.fromJson(json: json.decode(response.body));
      }
    } on TimeoutException {
      throw Exception("Timeout... ");
    } catch (e) {
      throw Exception(e.toString());
    }
  }

//-------------------------------------------------------------------------------------------

//---------------------------------Update Status of Affected Aid Request-----------------------------------------------



  // Widget _buildUpdateStatusAffectedRequest(BuildContext context) {
  //   final _idController = TextEditingController();
  //   AidRequest? _selectedStatus;

  //   return AlertDialog(
  //     title: Text('Update Status of Affected Aid Request'),
  //     content: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         TextField(
  //           controller: _idController,
  //           decoration: InputDecoration(labelText: 'Aid Request ID'),
  //           keyboardType: TextInputType.number,
  //         ),
  //         DropdownButton<AidRequest>(
  //           hint: Text('Select Status'),
  //           value: _selectedStatus,
  //           items: AidRequest.map((AidRequest status) {
  //             return DropdownMenuItem<AidRequest>(
  //               value: status,
  //               child: Text(status.toString().split('.').last),
  //             );
  //           }).toList(),
  //           onChanged: (AidRequest? newValue) {
  //             _selectedStatus = newValue;
  //           },
  //         ),
  //       ],
  //     ),
  //     actions: [
  //       TextButton(
  //         onPressed: () => Navigator.pop(context),
  //         child: Text('Cancel'),
  //       ),
  //       TextButton(
  //         onPressed: () async {
  //           final id = int.tryParse(_idController.text);
  //           final status = _selectedStatus;

  //           if (id == null || status == null) {
  //             ScaffoldMessenger.of(context).showSnackBar(
  //               SnackBar(
  //                 content: Text('Invalid ID or Status'),
  //                 backgroundColor: Colors.red,
  //               ),
  //             );
  //             return;
  //           }

  //           final response = await updateAidRequestStatus(id, status.index);

  //           if (response.succeeded == true) {
  //             ScaffoldMessenger.of(context).showSnackBar(
  //               SnackBar(
  //                 content: Text('Aid Request status updated successfully!'),
  //                 backgroundColor: Colors.green,
  //               ),
  //             );
  //             Navigator.pop(context);
  //           } else {
  //             ScaffoldMessenger.of(context).showSnackBar(
  //               SnackBar(
  //                 content: Text('Failed to update aid request status: ${response.message}'),
  //                 backgroundColor: Colors.red,
  //               ),
  //             );
  //           }
  //         },
  //         child: Text('Update'),
  //       ),
  //     ],
  //   );
  // }






  Future<BaseModel<int>> updateAidRequestStatus(
    int id,
    int status,
  ) async {
    try {
      var url = Uri.https(
        SI.serverName,
        '${SI.api}/${SI.aidRequest}/update-status',
      );
      final http.Response response = await http
          .put(
            url,
            headers: Me.instance.header,  
            body: jsonEncode(<String, dynamic>{
              "id": id,
              "status": status,
            }),
          )
          .timeout(const Duration(seconds: 60));
      switch (response.statusCode) {
        case 200:
          return BaseModel<int>.fromJson(
            json: json.decode(response.body),
            d: int.tryParse(json.decode(response.body)["data"]) ?? 0,
          );
        default:
          return BaseModel.fromJson(json: json.decode(response.body));
      }
    } on TimeoutException {
      throw Exception("Timeout... ");
    } catch (e) {
      throw Exception(e.toString());
    }
  }



//-------------------------------------------------------------------------------------------
//---------------------------------Add Help Point-----------------------------------------------


  Widget _buildAddHelpPoint(BuildContext context) {
    final _nameController = TextEditingController();
    final _locationController = TextEditingController();
    final _statusController = TextEditingController();
    final _latitudeController = TextEditingController();
    final _longitudeController = TextEditingController();

    return AlertDialog(
      title: Text('Add Help Point'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(labelText: 'Location'),
            ),
            TextField(
              controller: _statusController,
              decoration: InputDecoration(labelText: 'Status'),
            ),
            TextField(
              controller: _latitudeController,
              decoration: InputDecoration(labelText: 'Latitude'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _longitudeController,
              decoration: InputDecoration(labelText: 'Longitude'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            final name = _nameController.text;
            final location = _locationController.text;
            final status = _statusController.text;
            final latitude = double.tryParse(_latitudeController.text);
            final longitude = double.tryParse(_longitudeController.text);

            if (name.isEmpty || location.isEmpty || status.isEmpty || latitude == null || longitude == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('All fields are required'),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            }

            final response = await addHelpPoint(name, location, status, latitude, longitude);

            if (response.succeeded == true) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Help point added successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pop(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Failed to add help point: ${response.message}'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: Text('Add'),
        ),
      ],
    );
  }






  Future<BaseModel<AidPointModel>> addHelpPoint(

    String name, 
    String location,
    String status,
    double latitude,
    double longitude


  ) async {
    try {
      var url = Uri.https(
        SI.serverName,
        '${SI.api}/${SI.aidPoint}/add',
      );
      final http.Response response = await http
          .post(
            url,
            headers: Me.instance.header,  
            body: jsonEncode(<String, dynamic>{
              "name": name,
              "location": location,
              "status": status,
              "latitude": latitude,
              "longitude": longitude,

            }),
          )
          .timeout(const Duration(seconds: 60));
      switch (response.statusCode) {
        case 200:
          return BaseModel<AidPointModel>.fromJson(
            json: json.decode(response.body),
            d: AidPointModel.fromJson(json.decode(response.body)??0,) ,
          );
        default:
          return BaseModel.fromJson(json: json.decode(response.body));
      }
    } on TimeoutException {
      throw Exception("Timeout... ");
    } catch (e) {
      throw Exception(e.toString());
    }
  }


