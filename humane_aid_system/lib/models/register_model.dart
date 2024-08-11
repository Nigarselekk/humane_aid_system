
import 'dart:convert';

class RegisterModel {
    final String? firstName;
    final String? lastName;
    final String? email;
    final String? userName;
    final String? phoneNumber;
    final String? password;
    final String? confirmPassword;
    final int? role;

    RegisterModel({
        this.firstName = '',
        this.lastName= '',
        this.email= '',
        this.userName= '',
        this.phoneNumber = '', 
        this.password = '',
        this.confirmPassword = '',
        this.role = 0,
    });

    factory RegisterModel.fromRawJson(String str) => RegisterModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        firstName: json["firstName"]?? '',
        lastName: json["lastName"] ?? '',
        email: json["email"]?? '',
        userName: json["userName"]?? '',
        phoneNumber: json["phoneNumber"]?? '',
        password: json["password"]?? '',
        confirmPassword: json["confirmPassword"]?? '',
        role: json["role"]?? 0,
    );

    Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "userName": userName,
        "phoneNumber": phoneNumber,
        "password": password,
        "confirmPassword": confirmPassword,
        "role": role,
    };
}










// import 'dart:convert';

// class RegisterModel {
//     String? firstName;
//     String? lastName;
//     String? email;
//     String? password;
//     String? confirmPassword;

//     RegisterModel({
//         this.firstName,
//         this.lastName,
//         this.email,
//         this.password,
//         this.confirmPassword,
//     });

//     factory RegisterModel.fromRawJson(String str) => RegisterModel.fromJson(json.decode(str));

//     String toRawJson() => json.encode(toJson());

//     factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
//         firstName: json["firstName"],
//         lastName: json["lastName"],
//         email: json["email"],
//         password: json["password"],
//         confirmPassword: json["confirmPassword"],
//     );

//     Map<String, dynamic> toJson() => {
//         "firstName": firstName,
//         "lastName": lastName,
//         "email": email,
//         "password": password,
//         "confirmPassword": confirmPassword,
//     };
// }



// class RegisterRequest {
//   final String firstName;
//   final String lastName;
//   final String email;
//   final String password;
//   final String confirmPassword;

//   RegisterRequest({
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     required this.password,
//     required this.confirmPassword,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'firstName': firstName,
//       'lastName': lastName,
//       'email': email,
//       'password': password,
//       'confirmPassword': confirmPassword,
//     };
//   }
// }


// class RegisterResponse {
//   final bool succeeded;
//   final String message;
//   final dynamic errors;
//   final dynamic data;

//   RegisterResponse({
//     required this.succeeded,
//     required this.message,
//     this.errors,
//     this.data,
//   });

//   factory RegisterResponse.fromJson(Map<String, dynamic> json) {
//     return RegisterResponse(
//       succeeded: json['Succeeded'],
//       message: json['Message'],
//       errors: json['Errors'],
//       data: json['Data'],
//     );
//   }
// }
