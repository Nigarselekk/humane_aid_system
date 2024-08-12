import 'package:flutter/material.dart';
import 'package:humane_aid_system/pages/addAddPointPage.dart';
import 'package:humane_aid_system/pages/map_screen.dart';

class AdminMainPage extends StatefulWidget {
  @override
  _AdminMainPageState createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage> {
  String? selectedHelpPointName;
  String? selectedHelpPointCoordinates;
  String? selectedProductCategory;

  // Method to add a help point
  void addHelpPoint(String name, String coordinates) {
    // Implement adding help point functionality here
    print('Help point added: $name, $coordinates');
  }

  // Method to delete a help point
  void removeHelpPoint(String name, String coordinates) {
    // Implement deleting help point functionality here
    print('Help point deleted: $name, $coordinates');
  }

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
                    // showDialog(
                    //   context: context,
                    //   builder: (_) => _buildAddHelpPointDialog(),
                    // );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddAidPointPage(),
                      ),
                    );



                  },
                ),
                CustomButton(
                  text: 'Remove Help Point',
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => _buildRemoveHelpPointDialog(),
                    );
                  },
                ),
                CustomButton(
                  text: 'Update Status of Help Point',
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => _buildUpdateStatusHelpPoint(),
                    );
                  },
                ),
                CustomButton(
                  text: 'Create Product',
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => _buildCreateProduct(),
                    );
                  },
                ),
                CustomButton(
                  text: 'Delete Product',
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => _buildDeleteProduct(),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Method to build dialog for adding a help point
  Widget _buildAddHelpPointDialog() {
    return AlertDialog(
      title: Text('Add Help Point'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Help Point Name'),
              onChanged: (value) {
                selectedHelpPointName = value;
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Help Point Coordinates'),
              onChanged: (value) {
                selectedHelpPointCoordinates = value;
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Add'),
          onPressed: () {
            addHelpPoint(selectedHelpPointName!, selectedHelpPointCoordinates!);
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    '$selectedHelpPointName at $selectedHelpPointCoordinates added!'),
              ),
            );
          },
        ),
      ],
    );
  }

  // Method to build dialog for deleting a help point
  Widget _buildRemoveHelpPointDialog() {
    return AlertDialog(
      title: Text('Delete Help Point'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Help Point Name'),
              onChanged: (value) {
                selectedHelpPointName = value;
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Help Point Coordinates'),
              onChanged: (value) {
                selectedHelpPointCoordinates = value;
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Delete'),
          onPressed: () {
            // Show confirmation dialog before deleting
            showDeleteConfirmationDialog(
                selectedHelpPointName!, selectedHelpPointCoordinates!);
          },
        ),
      ],
    );
  }

  // Method to build dialog for updating a product
  Widget _buildCreateProduct() {
    return AlertDialog(
      title: Text('Create Product'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Product Category'),
              onChanged: (value) {
                selectedProductCategory = value;
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Product Name'),
              onChanged: (value) {
                selectedHelpPointName = value;
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Product Coordinates'),
              onChanged: (value) {
                selectedHelpPointCoordinates = value;
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Update'),
          onPressed: () {
            // Show confirmation dialog before deleting
            showDeleteConfirmationDialog(
                selectedHelpPointName!, selectedHelpPointCoordinates!);
          },
        ),
      ],
    );
  }

  // Method to show confirmation dialog before delete operation
  Future<void> showDeleteConfirmationDialog(
      String name, String coordinates) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Help Point'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Are you sure you want to delete the help point $name at $coordinates?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Remove'),
              onPressed: () {
                removeHelpPoint(name, coordinates);
                Navigator.of(context).pop();
                // Show snackbar message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('$name at $coordinates removed!'),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildUpdateStatusHelpPoint() {
    return AlertDialog(
      title: Text('Update Status of Help Point'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Help Point Name'),
              onChanged: (value) {
                selectedHelpPointName = value;
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Help Point Coordinates'),
              onChanged: (value) {
                selectedHelpPointCoordinates = value;
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Help Point Status'),
              onChanged: (value) {
                selectedHelpPointCoordinates = value;
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Update'),
          onPressed: () {
            // Show confirmation dialog before deleting
            showDeleteConfirmationDialog(
                selectedHelpPointName!, selectedHelpPointCoordinates!);
          },
        ),
      ],
    );
  }

  Widget _buildDeleteProduct() {
    return AlertDialog(
      title: Text('Delete Product'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Product Name'),
              onChanged: (value) {
                selectedHelpPointName = value;
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Product Coordinates'),
              onChanged: (value) {
                selectedHelpPointCoordinates = value;
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Delete'),
          onPressed: () {
            // Show confirmation dialog before deleting
            showDeleteConfirmationDialog(
                selectedHelpPointName!, selectedHelpPointCoordinates!);
          },
        ),
      ],
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  CustomButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: double.infinity, // Make the button take the full width
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            textStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          child: Text(text),
        ),
      ),
    );
  }
}
