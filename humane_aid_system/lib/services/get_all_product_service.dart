import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:humane_aid_system/models/get_all_product_model.dart';
import 'package:humane_aid_system/my_service/my_service%20copy/constant.dart';
import 'package:humane_aid_system/my_service/my_service%20copy/server_info.dart';
import 'package:humane_aid_system/my_service/my_service_models%20copy/base_model.dart';

class GetAllProductService {
  static Future<BaseModel<List<GetAllProductModel>>> getAllProducts() async {
    try {
      var url = Uri.https(
        SI.serverName,
        '${SI.api}/${SI.product}/get-all',
      );
      final http.Response response = await http
          .get(
            url,
            headers: Me.instance.header,
          )
          .timeout(const Duration(seconds: 60));
      switch (response.statusCode) {
        case 200:
          Map<String, dynamic> jsonData = json.decode(response.body);
          List<dynamic> dataList = jsonData['data'];
          List<GetAllProductModel> products = dataList.map((item) => GetAllProductModel.fromJson(item)).toList();
          return BaseModel<List<GetAllProductModel>>(
            succeeded: true,
            data: products,
          );
        default:
          return BaseModel<List<GetAllProductModel>>.fromJson(json: json.decode(response.body));
      }
    } on TimeoutException {
      throw Exception("Timeout... ");
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
