// import 'dart:convert';


// class AuthenticateModel {
//     String? email;
//     String? password;

//     AuthenticateModel({
//         this.email,
//         this.password,
//     });

//     factory AuthenticateModel.fromRawJson(String str) => AuthenticateModel.fromJson(json.decode(str));

//     String toRawJson() => json.encode(toJson());

//     factory AuthenticateModel.fromJson(Map<String, dynamic> json) => AuthenticateModel(
//         email: json["email"],
//         password: json["password"],
//     );

//     Map<String, dynamic> toJson() => {
//         "email": email,
//         "password": password,
//     };
// }



// // Class for authentication request
// class AuthenticateRequest {
//   final String email;
//   final String password;

//   AuthenticateRequest({
//     required this.email,
//     required this.password,
//   });

//   Map<String, dynamic> toJson() => {
//         'email': email,
//         'password': password,
//       };
// }

// // Class for authentication response
// class AuthenticateResponse {
//   final bool succeeded;
//   final String message;
//   final List<String>? errors;
//   final dynamic data;

//   AuthenticateResponse({
//     required this.succeeded,
//     required this.message,
//     this.errors,
//     this.data,
//   });

//   factory AuthenticateResponse.fromJson(Map<String, dynamic> json) {
//     return AuthenticateResponse(
//       succeeded: json['Succeeded'],
//       message: json['Message'],
//       errors: json['Errors'] != null ? List<String>.from(json['Errors']) : null,
//       data: json['Data'],
//     );
//   }
// }

// // Example usage of serialization and deserialization
// void main() {
//   // Example request
//   var request = AuthenticateRequest(email: 'example@example.com', password: 'password');
//   var requestJson = jsonEncode(request.toJson());
//   print('Request JSON: $requestJson');

//   // Example response JSON
//   var responseJson = '''{
//     "Succeeded": succeeded,
//     "Message": "",
//     "Errors": null,
//     "Data": null
//   }''';

//   var response = AuthenticateResponse.fromJson(jsonDecode(responseJson));
//   print('Response: succeeded=${response.succeeded}, message=${response.message}');
// }




