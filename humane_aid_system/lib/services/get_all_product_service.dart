import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:humane_aid_system/models/get_all_product_model.dart';
import 'package:humane_aid_system/my/my_service/constant.dart';
import 'package:humane_aid_system/my/my_service/server_info.dart';
import 'package:humane_aid_system/my/my_service_models/base_model.dart';

class GetAllProductService {
  static Future<BaseModel<List<GetAllProductModel>>> getAllProducts() async {
    try {
      var url = Uri.https(
        SI.serverName,
        '${SI.api}/${SI.product}/get-all',
      );
      final http.Response response = await http.get(
        url,
        headers: Me.instance.header,
      ).timeout(const Duration(seconds: 60));

      if (response.statusCode == 200) {
        List<dynamic> dataList = json.decode(response.body)['data'];
        List<GetAllProductModel> products = dataList
            .map((item) => GetAllProductModel.fromJson(item))
            .toList();
        return BaseModel<List<GetAllProductModel>>(
          succeeded: true,
          data: products,
        );
      } else {
        return BaseModel<List<GetAllProductModel>>.fromJson(
            json: json.decode(response.body));
      }
    } on TimeoutException {
      throw Exception("Timeout... ");
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
