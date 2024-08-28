import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:humane_aid_system/models/aidPoint_model.dart';
import 'package:humane_aid_system/my/my_service/constant.dart';
import 'package:humane_aid_system/my/my_service/server_info.dart';
import 'package:humane_aid_system/my/my_service_models/base_model.dart';

class AidPointService {
  static Future<BaseModel<AidPointModel>> addAidPoint(
    String name,
    // String aidPointId,
    String location,
    String status,
    double latitude,
    double longitude,
  ) async {
    try {
      var url = Uri.https(
        SI.serverName,
        '${SI.api}/${SI.aidPoint}/add',
      );
      final http.Response response = await http
          .post(
            url,
            headers: Me.instance.header,
            body: json.encode(
              <String, dynamic>{
                "name": name,
                // "aidPointId": aidPointId,
                "location": location,
                "status": status,
                "latitude": latitude,
                "longitude": longitude,
              },
            ),
          )
          .timeout(const Duration(seconds: 60));

      if (response.statusCode == 200) {
        return BaseModel<AidPointModel>.fromJson(
          json: json.decode(response.body),
          d: AidPointModel.fromJson(json.decode(response.body) ?? {}),
        );
      } else {
        return BaseModel<AidPointModel>.fromJson(
          json: json.decode(response.body),
        );
      }
    } on TimeoutException {
      throw Exception("Timeout... ");
    } catch (e) {
      throw Exception(e.toString());
    }
  }






  static Future<Map<String, dynamic>> searchAidPoints(String keyword) async {
  try {
    var url = Uri.https(
      SI.serverName,
      '${SI.api}/${SI.aidPoint}/search',
      {'keyword': keyword},
    );
    final response = await http.get(url, headers: Me.instance.header);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to search aid points');
    }
  } catch (e) {
    throw Exception('Failed to search aid points: $e');
  }
}








  static Future<BaseModel<List<AidPointModel>>> AddAidPoint() async {
    try {
      var url = Uri.https(
        SI.serverName,
        '${SI.api}/${SI.aidPoint}/add',
      );
      final http.Response response = await http
          .get(
            url,
            headers: Me.instance.header,
          )
          .timeout(const Duration(seconds: 60));

      if (response.statusCode == 200) {
        List<dynamic> dataList =
            json.decode(response.body)['data']; // Corrected line
        List<AidPointModel> aidPoints =
            dataList.map((item) => AidPointModel.fromJson(item)).toList();
        return BaseModel<List<AidPointModel>>(
          succeeded: true,
          data: aidPoints,
        );
      } else {
        return BaseModel<List<AidPointModel>>.fromJson(
            json: json.decode(response.body));
      }
    } on TimeoutException {
      throw Exception("Timeout... ");
    } catch (e) {
      throw Exception(e.toString());
    }
  }





  static Future<BaseModel<List<AidPointModel>>> getAidPoints() async {
    try {
      var url = Uri.https(
        SI.serverName,
        '${SI.api}/${SI.aidPoint}',
      );
      final http.Response response = await http
          .get(
            url,
            headers: Me.instance.header,
          )
          .timeout(const Duration(seconds: 60));

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        List<dynamic> dataList = jsonData['data'];
        List<AidPointModel> aidPoints =
            dataList.map((item) => AidPointModel.fromJson(item)).toList();
        return BaseModel<List<AidPointModel>>(
          succeeded: true,
          data: aidPoints,
        );
      } else {
        return BaseModel<List<AidPointModel>>.fromJson(
            json: json.decode(response.body));
      }
    } on TimeoutException {
      throw Exception("Timeout... ");
    } catch (e) {
      throw Exception(e.toString());
    }
  }


  // static Future<BaseModel<List<AidPointModel>>> getAllAidPoints(
  //   // int id,
  //   String name,
  //   String location,
  //   String status,

  // ) async {
  //   try {
  //     var url = Uri.https(
  //       SI.serverName,
  //       '${SI.api}/${SI.aidPoint}/get-all',
  //     );
  //     final http.Response response = await http
  //         .get(
  //           url,
  //           headers: Me.instance.header,
            


  //   )
    
  //         .timeout(const Duration(seconds: 60));

  //     if (response.statusCode == 200) {
  //       return BaseModel<List<AidPointModel>>.fromJson(
  //           json: json.decode(response.body),
  //           d: json.decode(response.body) ?? []
  //         );
  //     } else {
  //       return BaseModel<List<AidPointModel>>.fromJson(
  //           json: json.decode(response.body));
  //     }
    
  
  //   } on TimeoutException {
  //     throw Exception("Timeout... ");
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   }
  // }
  
   








}




