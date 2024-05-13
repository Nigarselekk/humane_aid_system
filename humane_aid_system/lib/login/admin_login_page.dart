import 'package:flutter/material.dart';
import 'package:humane_aid_system/pages/main_page.dart';

class AdminLoginPage extends StatefulWidget {
  @override
  _AdminLoginPageState createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  var _emailErrorText;
  var _passwordErrorText;
  void _validateInputs() {
    setState(() {
      _emailErrorText =
          _emailController.text.isEmpty ? 'Email is required.' : null;
      _passwordErrorText = _passwordController.text.isEmpty
          ? 'Password is required.'
          : null;
    });
  }

  // String _validateEmail(String value) {
  //   if (value.isEmpty) {
  //     return 'Email alanı boş bırakılamaz';
  //   }
  //   return "";
  // }

  // String _validatePassword(String value) {
  //   if (value.isEmpty) {
  //     return 'Şifre alanı boş bırakılamaz';
  //   }
  //   return "";
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Login'),
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
              onPressed: () {
                _validateInputs(); // Giriş yapmadan önce alanları kontrol edin
                if (_emailController.text.isNotEmpty &&
                    _passwordController.text.isNotEmpty) {
                  // Burada email ve şifreyi alıp doğrulama işlemini yapabilirsiniz
                  Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MainPage()),
                      );
                }
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
