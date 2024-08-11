import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:humane_aid_system/models/donation_model.dart';
import 'package:humane_aid_system/my_service/my_service%20copy/constant.dart';
import 'package:humane_aid_system/my_service/my_service%20copy/server_info.dart';
import 'dart:convert';

import 'package:humane_aid_system/my_service/my_service_models%20copy/base_model.dart';

class DonationService {

  static Future<BaseModel<List<DonationModel>>> fetchDonations(
    String category,
    List<String> products,

  ) async {
    try {
      var url = Uri.https(
        SI.serverName,
        '${SI.api}/${SI.aidOffer}/make-donation',
      );
      final http.Response response = await http
          .post(
            url,
            headers: Me.instance.header,
            body: jsonEncode(<String, dynamic>{
              "category": category,
              "products": products,

            }),


          )
          .timeout(const Duration(seconds: 60));
      switch (response.statusCode) {
        case 200:
          return BaseModel<List<DonationModel>>.fromJson(
            json: json.decode(response.body),
            d: (json.decode(response.body) as List)
                .map((item) => DonationModel.fromJson(item))
                .toList(),
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

  static Future<BaseModel<DonationModel>> createDonation(DonationModel donation) async {
    try {
      var url = Uri.https(
        SI.serverName,
        '${SI.api}/${SI.aidOffer}/make-donation',
      );
      final http.Response response = await http
          .post(
            url,
            headers: Me.instance.header,
            body: jsonEncode(donation.toJson()),
          )
          .timeout(const Duration(seconds: 60));
      switch (response.statusCode) {
        case 200:
          return BaseModel<DonationModel>.fromJson(
            json: json.decode(response.body),
            d: DonationModel.fromJson(json.decode(response.body) ?? {}),
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

  static Future<BaseModel<bool>> deleteDonation(String donationId) async {
    try {
      var url = Uri.https(
        SI.serverName,
        '${SI.api}/${SI.aidOffer}/make-donation',
      );
      final http.Response response = await http
          .delete(
            url,
            headers: Me.instance.header,
          )
          .timeout(const Duration(seconds: 60));
      switch (response.statusCode) {
        case 200:
          return BaseModel<bool>.fromJson(
            json: json.decode(response.body),
            d: json.decode(response.body) ?? false,
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
