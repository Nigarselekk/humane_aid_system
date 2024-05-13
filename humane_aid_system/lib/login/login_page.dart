import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:humane_aid_system/login/register_page.dart';
import 'package:humane_aid_system/login/affected_login_page.dart';
import 'package:humane_aid_system/login/donor_login_page.dart';
import 'package:humane_aid_system/login/admin_login_page.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Humane Aid System'),
        backgroundColor: Color.fromARGB(255, 98, 148, 195),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Harita widget'ınızı buraya ekleyin
            // Placeholder widget'ı sadece bir yer tutucu olarak kullanılmıştır,
            // Gerçek harita widget'ınızı bu yere eklemelisiniz

            Placeholder(
              color: Colors.black,
            ),
            SizedBox(height: 16.0),
            Center(
              child: ListBody(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Log in to make a request.',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      // Afetzede girişi için işlevi çağır
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AffectedLoginPage()),
                      );
                    },
                    child: Text('Affected Login',
                        style: TextStyle(color: Colors.black)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Yardım eden girişi için işlevi çağır
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DonorLoginPage()),
                      );
                    },
                    child: Text('Donor Login',
                        style: TextStyle(color: Colors.black)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Admin girişi için işlevi çağır
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AdminLoginPage()),
                      );
                    },
                    child: Text('Admin Login',
                        style: TextStyle(color: Color(0xFF000000))),
                  ),
                  SizedBox(height: 16.0),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      // Kayıt olma sayfasına git
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },
                    child: const Text(
                        'If you don\'t have an account, register here.'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
