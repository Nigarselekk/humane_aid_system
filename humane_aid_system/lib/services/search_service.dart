import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:humane_aid_system/models/search_model.dart';
import 'package:humane_aid_system/my_service/my_service%20copy/constant.dart';
import 'package:humane_aid_system/my_service/my_service%20copy/server_info.dart';
import 'package:humane_aid_system/my_service/my_service_models%20copy/base_model.dart';

class SearchService {
  static Future<BaseModel<SearchModel>> search(
    String query,
  ) async {
    try {
      var url = Uri.https(
        SI.serverName,
        '${SI.api}/${SI.aidPoint}/search',
        {'query': query},
      );
      final http.Response response = await http
          .get(
            url,
            headers: Me.instance.header,
          )
          .timeout(const Duration(seconds: 60));
      switch (response.statusCode) {
        case 200:
          return BaseModel<SearchModel>.fromJson(
            json: json.decode(response.body),
            d: SearchModel.fromJson(json.decode(response.body) ?? {}),
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
