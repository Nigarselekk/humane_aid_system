import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:humane_aid_system/my_service/my_service/server_info.dart';
import 'package:humane_aid_system/my_service/my_service_models/base_model.dart';

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
            headers: {
              "Content-Type": "application/json",
              'Authorization':
                  'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZmZlY3RlZCIsImp0aSI6IjE2ODY1Zjc0LTYxYjEtNDYzNS1hZWU5LTUyNWQ1YjNlMzZlMyIsImVtYWlsIjoiYWZmZWN0ZWRAZXhhbXBsZS5jb20iLCJ1aWQiOiJlZjY3NGYyYS1lNDYyLTRjNmMtYWE1OC0wMzY4MmJjM2EwOTQiLCJpcCI6IjEwLjAuMC41Iiwicm9sZXMiOiJEaXNhc3RlckFmZmVjdGVkIiwiZXhwIjoxNzE3MDMzMjU4LCJpc3MiOiJDb3JlSWRlbnRpdHkiLCJhdWQiOiJDb3JlSWRlbnRpdHlVc2VyIn0.OFoJ81E9ib3e84Qf9OQUrgfuh-B4E0lq_FGJDo_0HtE',
            },
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
