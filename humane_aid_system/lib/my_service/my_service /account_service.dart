import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:humane_aid_system/my_service/my_service%20copy/constant.dart';
import 'package:humane_aid_system/my_service/my_service%20copy/server_info.dart';
import 'package:humane_aid_system/my_service/my_service_models%20copy/account_models/authenticate_model.dart';
import 'dart:convert';

import 'package:humane_aid_system/my_service/my_service_models%20copy/base_model.dart';

class AccountService {
  static Future<BaseModel<AuthenticateModel>> authenticate(
    String email,
    String password,
  ) async {
    try {
      var url = Uri.https(
        SI.serverName,
        '${SI.api}/${SI.account}/authenticate',
      );
      final http.Response response = await http
          .post(
            url,
            headers: Me.instance.header,  
            body: jsonEncode(<String, dynamic>{
              "email": email,
              "password": password,
            }),
          )
          .timeout(const Duration(seconds: 60));
      switch (response.statusCode) {
        case 200:
          return BaseModel<AuthenticateModel>.fromJson(
            json: json.decode(response.body),
            d: AuthenticateModel.fromJson(json.decode(response.body) ?? {}),
          );
        default:
          return BaseModel.fromJson(json: json.decode(response.body));
      }
    } on TimeoutException {
      throw Exception("Timeout... ");
    } catch (e) {
      throw Exception(e.toString());
    }
  }



  static Future<BaseModel<int>> getAnInt(
    int ali,
    bool veli,
  ) async {
    try {
      var url = Uri.https(
        SI.serverName,
        '${SI.api}/${SI.account}/authenticate',
      );
      final http.Response response = await http
          .post(
            url,
            headers: Me.instance.header,  
            body: jsonEncode(<String, dynamic>{
              "ali": ali,
              "veli": veli,
            }),
          )
          .timeout(const Duration(seconds: 60));
      switch (response.statusCode) {
        case 200:
          return BaseModel<int>.fromJson(
            json: json.decode(response.body),
            d: int.tryParse(json.decode(response.body)["data"]) ?? 0,
          );
        default:
          return BaseModel.fromJson(json: json.decode(response.body));
      }
    } on TimeoutException {
      throw Exception("Timeout... ");
    } catch (e) {
      throw Exception(e.toString());
    }
  }


}
