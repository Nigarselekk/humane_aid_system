import 'package:flutter/material.dart';
import 'package:humane_aid_system/login/forget_password_page.dart';
import 'package:humane_aid_system/login/login_page.dart';
import 'package:humane_aid_system/login/register_page.dart';
import 'package:humane_aid_system/pages/affected_main_page.dart';
import 'package:humane_aid_system/my/my_service/account_service.dart';
import 'package:humane_aid_system/my/my_service/constant.dart';
import 'package:humane_aid_system/my/my_service_models/account_models/authenticate_model.dart';
import 'package:humane_aid_system/my/my_service_models/base_model.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _myController1 = TextEditingController();
  final _myController2 = TextEditingController();
  String _email = "";
  String _password = "";

  @override
  void initState() {

    _autoLogIn();
    
    super.initState();
  }

  @override
  void dispose() {
    _myController1.dispose();
    _myController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height / 20,
                      ),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextField(
                        controller: _myController1,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.person,
                            size: 30,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: _email == "" ? "E Posta" : _email,
                        ),
                        onChanged: (input) {
                          setState(() {
                            _email = _myController1.text;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextField(
                        controller: _myController2,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.lock_rounded,
                            size: 30,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: "Parola",
                        ),
                        onChanged: (input) {
                          setState(() {
                            _password = _myController2.text;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height / 10,
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          _showInfo(
                              AccountService.authenticate(_email, _password));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Center(
                            child: Text("Oturum Aç",
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 20)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgotPasswordPage()),
                    );
                  },
                  child: Text("Forgot Password?"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Text("Sign Up"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showInfo(Future<BaseModel<AuthenticateModel>> _myFuture) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => FutureBuilder<BaseModel<AuthenticateModel>>(
        future: _myFuture,
        builder:
            (context, AsyncSnapshot<BaseModel<AuthenticateModel>> snapshot) {
          if (snapshot.hasData && snapshot.data!.succeeded == false) {
            return SimpleDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              title: Center(child: Text("Bilgi")),
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 50,
                  ),
                  child: Text(snapshot.data!.message!.toString()),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SimpleDialogOption(
                        child: Center(
                          child: Text(
                            "Tamam",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return SimpleDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              title: Text("Bilgi"),
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 50,
                  ),
                  child: Text(snapshot.error.toString()),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SimpleDialogOption(
                        child: Center(
                          child: Text(
                            "Tamam",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (snapshot.hasData && snapshot.data!.succeeded == true) {
            return SimpleDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              title: Text("Başarılı"),
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SimpleDialogOption(
                        child: Center(
                          child: Text(
                            "Tamam",
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                        onPressed: () async {
                          _saveInfoAndJump(snapshot.data!.data!);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return SimpleDialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              children: [
                Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
    _myFuture.then((value) {
      if (value.succeeded!) {
        _saveInfoAndJump(
          value.data!,
        );
      }
      return null;
    });
  }

  void _autoLogIn() async {
    Me.instance.autoLogIn.then((value) {
      if (value) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const AffectedMainPage()),
            (route) => false);
      }
    });
  }

  Future<void> _saveInfoAndJump(AuthenticateModel newInfo) async {
    await Me.instance.logInAndSaveInfo(newInfo);
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const AffectedMainPage()));
  }
}
