
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:humane_aid_system/models/register_model.dart';
import 'package:humane_aid_system/my_service/my_service%20copy/constant.dart';
import 'package:humane_aid_system/my_service/my_service%20copy/server_info.dart';
import 'package:humane_aid_system/my_service/my_service_models%20copy/base_model.dart';

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
      switch (response.statusCode) {
        case 200:
          return BaseModel<RegisterModel>.fromJson(
            json: json.decode(response.body),
            d: RegisterModel.fromJson(json.decode(response.body) ?? {}),
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










// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:humane_aid_system/models/register_request_model.dart';

// class ApiService {
//   final String baseUrl;

//   ApiService({required this.baseUrl});

//   Future<RegisterResponse> register(RegisterRequest request) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/api/account/register'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode(request.toJson()),
//     );

//     if (response.statusCode == 200) {
//       return RegisterResponse.fromJson(jsonDecode(response.body));
//     } else {
//       throw Exception('Failed to register');
//     }
//   }
// }



