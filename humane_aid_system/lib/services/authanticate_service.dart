// import 'package:http/http.dart' as http;
// import 'package:humane_aid_system/models/authenticate_model.dart';
// import 'dart:convert';

// class ApiService {
//   final String baseUrl;

//   ApiService(this.baseUrl);

//   Future<AuthenticateResponse> authenticate(String email, String password) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/api/Account/authenticate'),
//       headers: {'Content-Type': 'application/json'},
//       body: json.encode(AuthenticateRequest(email: email, password: password).toJson()),
//     );

//     if (response.statusCode == 200 || response.statusCode == 201) {
//       return AuthenticateResponse.fromJson(json.decode(response.body));
//     } else {
//       throw Exception('Failed to authenticate: ${response.statusCode}');
//     }
//   }
// }
