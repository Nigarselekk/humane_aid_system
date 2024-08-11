import 'package:flutter/material.dart';
import 'package:humane_aid_system/login/login_page.dart';
import 'package:humane_aid_system/services/ApiService.dart';

class RegisterPage extends StatefulWidget {
  final ApiService apiService;

  const RegisterPage({Key? key, required this.apiService}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  var _nameErrorText ;
  var _surnameErrorText;
  var _emailErrorText;
  var _passwordErrorText;
  var _phoneErrorText;

  void _validateInputs() {
    setState(() {
      _nameErrorText = _nameController.text.isEmpty ? 'Name is required' : null;
      _surnameErrorText =
          _surnameController.text.isEmpty ? 'Surname is required' : null;
      _emailErrorText =
          _emailController.text.isEmpty ? 'Email is required' : null;
      _passwordErrorText =
          _passwordController.text.isEmpty ? 'Password is required' : null;
      _phoneErrorText =
          _phoneController.text.isEmpty ? 'Phone Number is required' : null;
    });
  }

  void _register() async {
    _validateInputs();
    if (_nameErrorText == null &&
        _surnameErrorText == null &&
        _emailErrorText == null &&
        _passwordErrorText == null &&
        _phoneErrorText == null) {
      try {
        final response = await widget.apiService.post('/api/Account/register', {
          'firstName': _nameController.text,
          'lastName': _surnameController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
          'confirmPassword': _passwordController.text,
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                errorText: _nameErrorText,
              ),
            ),
            // SizedBox(height: 10.0),
            TextFormField(
              controller: _surnameController,
              decoration: InputDecoration(
                labelText: 'Surname',
                errorText: _surnameErrorText,
              ),
            ),
            // SizedBox(height: 10.0),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                errorText: _emailErrorText,
              ),
            ),
            // SizedBox(height: 10.0),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                errorText: _passwordErrorText,
              ),
            ),
            // SizedBox(height: 10.0),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                errorText: _passwordErrorText,
              ),
            ),

            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                errorText: _phoneErrorText,
              ),
            ),

            ElevatedButton(
              onPressed: _register,
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
