import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:humane_aid_system/my/my_service/constant.dart';
import 'package:humane_aid_system/my/my_service/server_info.dart';
import 'package:humane_aid_system/my/my_service_models/account_models/authenticate_model.dart';
import 'dart:convert';
import 'package:humane_aid_system/my/my_service_models/base_model.dart';

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
            d: AuthenticateModel.fromJson(json.decode(response.body)["data"] ?? {}),
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

  static Future<BaseModel<bool>> resetPassword(String email) async {
    try {
      var url = Uri.https(
        SI.serverName,
        '${SI.api}/${SI.account}/forgot-password',
      );
      final http.Response response = await http
          .post(
            url,
            headers: Me.instance.header,
            body: jsonEncode(<String, dynamic>{
              "email": email,
            }),
          )
          .timeout(const Duration(seconds: 60));

      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        return BaseModel<bool>(
          succeeded: true,
          message: responseBody['message'] ??
              'Password reset link sent successfully',
          data: true,
        );
      } else {
        var responseBody = json.decode(response.body);
        return BaseModel<bool>(
          succeeded: false,
          message:
              responseBody['message'] ?? 'Failed to send password reset link',
          data: false,
        );
      }
    } on TimeoutException {
      return BaseModel<bool>(
        succeeded: false,
        message: 'Request timed out. Please try again later.',
        data: false,
      );
    } catch (e) {
      return BaseModel<bool>(
        succeeded: false,
        message: 'An error occurred: ${e.toString()}',
        data: false,
      );
    }
  }
}
