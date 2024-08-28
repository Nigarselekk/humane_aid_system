import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:humane_aid_system/models/register_model.dart';
import 'package:humane_aid_system/my/my_service/constant.dart';
import 'package:humane_aid_system/my/my_service/server_info.dart';
import 'package:humane_aid_system/my/my_service_models/base_model.dart';

class RegisterService {
  static Future<BaseModel<RegisterModel>> register(
    String firstName,
    String lastName,
    String email,
    String userName,
    String phoneNumber,
    String password,
    String confirmPassword,
    int role,
  ) async {
    try {
      var url = Uri.https(
        SI.serverName,
        '${SI.api}/${SI.account}/register',
      );
      final http.Response response = await http
          .post(
            url,
            headers: Me.instance.header,  
            body: jsonEncode(<String, dynamic>{
              "firstName": firstName,
              "lastName": lastName,
              "email": email,
              "userName": userName,
              "phoneNumber": phoneNumber,
              "password": password,
              "confirmPassword": confirmPassword,
              "role": role,
            }),
          )
          .timeout(const Duration(seconds: 60));
          
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return BaseModel<RegisterModel>.fromJson(
          json: jsonResponse,
          d: RegisterModel.fromJson(jsonResponse["data"] ?? {}),
        );
      } else {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return BaseModel.fromJson(json: jsonResponse);
      }
    } on TimeoutException {
      throw Exception("Timeout... ");
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}










