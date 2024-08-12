
import 'dart:convert';
class AuthenticateModel {
    final String? id;
    final String? userName;
    final String? email;
    final List<String>? roles;
    final bool? isVerified;
    final String? jwToken;

    AuthenticateModel({
        this.id="",
        this.userName="",
        this.email="",
        this.roles=const [],
        this.isVerified=false,
        this.jwToken="",
    });
    factory AuthenticateModel.fromRawJson(String str) => AuthenticateModel.fromJson(json.decode(str));
    String toRawJson() => json.encode(toJson());

    factory AuthenticateModel.fromJson(Map<String, dynamic> json) => AuthenticateModel(
        id: json["id"]??"",
        userName: json["userName"]??"",
        email: json["email"]??"",
        roles: json["roles"] == null ? [] : List<String>.from(json["roles"]!.map((x) => x)),
        isVerified: json["isVerified"]??false,
        jwToken: json["jwToken"]??"",
    );
    
      Map<String, dynamic> toJson() => {
        "id": id,
        "userName": userName,
        "email": email,
        "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x)),
        "isVerified": isVerified,
        "jwToken": jwToken,
    };
}
