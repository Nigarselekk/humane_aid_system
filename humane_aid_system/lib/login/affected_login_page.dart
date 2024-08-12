import 'package:flutter/material.dart';
import 'package:humane_aid_system/login/forget_password_page.dart';
import 'package:humane_aid_system/login/register_page.dart';
import 'package:humane_aid_system/pages/affected_main_page.dart';
import 'package:humane_aid_system/services/ApiService.dart';
import 'package:humane_aid_system/my_service/my_service/account_service.dart';
import 'package:humane_aid_system/my_service/my_service/constant.dart';
import 'package:humane_aid_system/my_service/my_service_models/account_models/authenticate_model.dart';
import 'package:humane_aid_system/my_service/my_service_models/base_model.dart';

class AffectedLoginPage extends StatefulWidget {


  final ApiService apiService;

  const AffectedLoginPage({Key? key, required this.apiService}) : super(key: key);

  @override
  _AffectedLoginPageState createState() => _AffectedLoginPageState();




}

class _AffectedLoginPageState extends State<AffectedLoginPage> {

  final _myController1 = TextEditingController();
  final _myController2 = TextEditingController();
  String _email = "";
  String _password = "";

  @override
  void initState() {

    // _autoLogIn();

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
          _buildBackground(),
          _buildLoginForm(context),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade200, Colors.blue.shade900],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLogo(),
            SizedBox(height: 20),
            _buildEmailTextField(context),
            SizedBox(height: 10),
            _buildPasswordTextField(context),
            SizedBox(height: 30),
            _buildLoginButton(context),
            SizedBox(height: 10),
            _buildForgotPasswordButton(context),
            _buildSignUpButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Icon(
        Icons.person,
        size: 100,
        color: Colors.blue.shade900,
      ),
    );
  }

  Widget _buildEmailTextField(BuildContext context) {
    return TextField(
      controller: _myController1,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.person, size: 30),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: "Email",
        filled: true,
        fillColor: Colors.white,
      ),
      onChanged: (input) {
        setState(() {
          _email = _myController1.text;
        });
      },
    );
  }

  Widget _buildPasswordTextField(BuildContext context) {
    return TextField(
      controller: _myController2,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock_rounded, size: 30),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: "Password",
        filled: true,
        fillColor: Colors.white,
      ),
      obscureText: true,
      onChanged: (input) {
        setState(() {
          _password = _myController2.text;
        });
      },
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 5, backgroundColor: Colors.blue.shade900,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
      ),
      onPressed: () {
        _showInfo(AccountService.authenticate(_email, _password));
      },
      child: Text(
        "Login",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }

  Widget _buildForgotPasswordButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
        );
      },
      child: Text(
        "Forgot Password?",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegisterPage()),
        );
      },
      child: Text(
        "Sign Up",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
    
      void _showInfo(Future<BaseModel<AuthenticateModel>> _myFuture) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => FutureBuilder<BaseModel<AuthenticateModel>>(
              future: _myFuture,
              builder: (context, AsyncSnapshot<BaseModel<AuthenticateModel>> snapshot) {
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
                } else if (snapshot.hasData &&
                    snapshot.data!.succeeded == true) {
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
                                _saveInfoAndJump(
                                  snapshot.data!.data!
                                );
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
            ));
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

  Future<void> _saveInfoAndJump(
    AuthenticateModel newInfo
  ) async {
    await Me.instance.logInAndSaveInfo(newInfo);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const AffectedMainPage()));
  }


}

