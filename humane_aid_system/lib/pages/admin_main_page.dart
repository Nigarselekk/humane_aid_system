import 'package:flutter/material.dart';
import 'package:humane_aid_system/pages/map_screen.dart';

class AdminMainPage extends StatefulWidget {
  @override
  _AdminMainPageState createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage> {
  String? selectedHelpPointName;
  String? selectedHelpPointCoordinates;

  // Method to add a help point
  void addHelpPoint(String name, String coordinates) {
    // Implement adding help point functionality here
    print('Help point added: $name, $coordinates');
  }

  // Method to delete a help point
  void deleteHelpPoint(String name, String coordinates) {
    // Implement deleting help point functionality here
    print('Help point deleted: $name, $coordinates');
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
              child: Text('Delete'),
              onPressed: () {
                // Perform delete operation
                deleteHelpPoint(name, coordinates);
                Navigator.of(context).pop();
                // Show snackbar message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('$name at $coordinates deleted!'),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
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
                ElevatedButton(
                  onPressed: () {
                    // Implement adding help point functionality
                    // Show dialog to get help point name and coordinates
                    showDialog(
                      context: context,
                      builder: (_) => _buildAddHelpPointDialog(),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                  ),
                  child: Text('Add Help Point'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Implement deleting help point functionality
                    // Show dialog to get help point name and coordinates
                    showDialog(
                      context: context,
                      builder: (_) => _buildDeleteHelpPointDialog(),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                  ),
                  child: Text('Delete Help Point'),
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
  Widget _buildDeleteHelpPointDialog() {
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

}
