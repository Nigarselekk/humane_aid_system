import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:humane_aid_system/my_service/my_service_models/account_models/authenticate_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Me {
  Me._();
  static final Me instance = Me._();

  AuthenticateModel _myInfo = AuthenticateModel();
  AuthenticateModel get myInfo => _myInfo;
  set setMe(AuthenticateModel newInfo) => _myInfo = newInfo;

  Map<String, String> get header => {
        HttpHeaders.contentTypeHeader: 'application/json',
      };

  Map<String, String> get authHeader => {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: "Bearer ${Me.instance.myInfo.jwToken}",
      };

  Future<bool> logInAndSaveInfo(AuthenticateModel myNewInfo) async {
    try {
      log(myNewInfo.toRawJson());
      log("Bilgiler tutuldu");
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('myInfo', myNewInfo.toRawJson());
      setMe = myNewInfo;
      return true;
    } on Exception {
      return false;
    }
  }

  Future<bool> get logOutAndSaveInfo async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('myInfo', "");
      setMe = AuthenticateModel();
      return true;
    } on Exception {
      return false;
    }
  }

  Future<bool> get autoLogIn async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? savedInfo = prefs.getString('myInfo');

      if (savedInfo != null && savedInfo != "") {
        setMe = AuthenticateModel.fromJson(jsonDecode(savedInfo));
        return true;
      } else {
        return false;
      }
    } on Exception {
      return false;
    }
  }
}
