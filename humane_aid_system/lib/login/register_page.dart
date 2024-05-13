import 'package:flutter/material.dart';
import 'package:humane_aid_system/login/login_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

    var _nameErrorText;
    var _surnameErrorText;
    var _emailErrorText;
    var _passwordErrorText;
    var _phoneErrorText;

  void _validateInputs() {
    setState(() {
      _nameErrorText = _nameController.text.isEmpty ? 'Name is required' : "";
      _surnameErrorText = _surnameController.text.isEmpty ? 'Surname is required' : "";
      _emailErrorText = _emailController.text.isEmpty ? 'Email is required' : "";
      _passwordErrorText = _passwordController.text.isEmpty ? 'Password is required' : "";
      _phoneErrorText = _phoneController.text.isEmpty ? 'Phone Number is required' : "";
    }
    );
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
            SizedBox(height: 16.0),
            TextFormField(
              controller: _surnameController,
              decoration: InputDecoration(
                labelText: 'Surname',
                errorText: _surnameErrorText,
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                errorText: _emailErrorText,
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                errorText: _passwordErrorText,
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                errorText: _phoneErrorText,
              ),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                _validateInputs(); // Register işleminden önce alanları kontrol edin
                if (_nameController.text.isNotEmpty &&
                    _surnameController.text.isNotEmpty &&
                    _emailController.text.isNotEmpty &&
                    _passwordController.text.isNotEmpty &&
                    _phoneController.text.isNotEmpty) {
                  // Register işlemini burada gerçekleştirin
                  // Örnek: Kayıt başarılı olduğunda bir sonraki sayfaya yönlendirme yapabilirsiniz
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                }
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
