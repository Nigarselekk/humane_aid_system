import 'package:flutter/material.dart';
import 'package:humane_aid_system/pages/affected_main_page.dart';
import 'package:humane_aid_system/services/ApiService.dart';

class AffectedLoginPage extends StatefulWidget {
  final ApiService apiService;

  const AffectedLoginPage({Key? key, required this.apiService}) : super(key: key);

  @override
  _AffectedLoginPageState createState() => _AffectedLoginPageState();
}

class _AffectedLoginPageState extends State<AffectedLoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  var _emailErrorText;
  var _passwordErrorText;

  void _validateInputs() {
    setState(() {
      _emailErrorText = !_emailController.text.contains('@') ? 'Please enter a valid email address.' : null;
      _passwordErrorText = _passwordController.text.isEmpty ? 'Password is required.' : null;
    });
  }

  void _login() async {
    _validateInputs();
    if (_emailErrorText == null && _passwordErrorText == null) {
      try {
        final response = await widget.apiService.post('/Account/authenticate', {
          'email': _emailController.text,
          'password': _passwordController.text,
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AffectedMainPage()),
        );
      } catch (e) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('Login failed: $e')
        //   ),
              Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AffectedMainPage()),
        );


        // );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Affected Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                errorText: _emailErrorText,
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                errorText: _passwordErrorText,
              ),
              obscureText: true,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

