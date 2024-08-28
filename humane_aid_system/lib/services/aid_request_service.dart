import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:humane_aid_system/my/my_service/server_info.dart';
import 'package:humane_aid_system/my/my_service_models/base_model.dart';

class AidRequestService {
  static Future<BaseModel<dynamic>> addAidRequest(
      List<Map<String, String>> products, String aidPointName) async {
    try {
      var url = Uri.https(
        SI.serverName,
        '${SI.api}/${SI.aidRequest}/add',
      );

      final response = await http
          .post(
            url,
            body: jsonEncode(<String, dynamic>{
              "products": products,
              "aidPointName": aidPointName,
            }),
          )
          .timeout(const Duration(seconds: 60));

      switch (response.statusCode) {
        case 200:
          return BaseModel<dynamic>.fromJson(
            json: json.decode(response.body),
            d: json.decode(response.body)['data'],
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
