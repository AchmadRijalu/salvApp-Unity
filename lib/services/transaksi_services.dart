import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:salv/models/aksi_transaksi_buyer_model.dart';
import 'package:salv/models/aksi_transaksi_seller_model.dart';
import 'package:salv/models/detail_transaksi_buyer_model.dart';
import 'package:salv/models/detail_transaksi_seller_model.dart';
import 'package:salv/models/transaksi_buyer_model.dart';

import '../models/jual_limbah_form_model.dart';
import '../models/jual_limbah_model.dart';
import '../models/transaksi_seller_model.dart';
import '../models/user_model.dart';
import '../shared/shared_values.dart';
import 'auth_services.dart';

class TransaksiService {
  Future<TransaksiSeller> getTransaksiSeller(dynamic user) async {
    try {
      final response = await http.get(
        Uri.parse("${baseUrlSalv}seller-transaction/index/${user}"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': await AuthService().getToken(),
        },
      );
      return TransaksiSeller.fromJson(json.decode(response.body));
    } catch (e) {
      rethrow;
    }
  }

  Future<TransaksiBuyer> getTransaksiBuyer(dynamic user) async {
    try {
      final response = await http.get(
        Uri.parse("${baseUrlSalv}buyer-transaction/index/${user}"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': await AuthService().getToken(),
        },
      );
      print(response.body);
      return TransaksiBuyer.fromJson(json.decode(response.body));
    } catch (e) {
      rethrow;
    }
  }

  Future<DetailTransaksiSeller> getTransaksiSellerDetail(dynamic id) async {
    try {
      final response = await http.get(
        Uri.parse("${baseUrlSalv}seller-transaction/${id}"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': await AuthService().getToken(),
        },
      );
      print("PRINT : ${response.body}");

      return DetailTransaksiSeller.fromJson(json.decode(response.body));
    } catch (e) {
      rethrow;
    }
  }

  Future<DetailTransaksiBuyer> getTransaksiBuyerDetail(dynamic id) async {
    try {
      final response = await http.get(
        Uri.parse("${baseUrlSalv}buyer-transaction/${id}"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': await AuthService().getToken(),
        },
      );
      print("PRINT : ${response.body}");

      return DetailTransaksiBuyer.fromJson(json.decode(response.body));
    } catch (e) {
      rethrow;
    }
  }

  Future<AksiTransaksiBuyer> getAksiTransaksiBuyer(
      dynamic transactionId, dynamic status) async {
    try {
      final response = await http.get(
        Uri.parse("${baseUrlSalv}buyer-transaction/${transactionId}/${status}"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': await AuthService().getToken(),
        },
      );
      print("PRINT : ${response.body}");
      return AksiTransaksiBuyer.fromJson(json.decode(response.body));
    } catch (e) {
      rethrow;
    }
  }

  Future<AksiTransaksiSeller> getAksiTransaksiSeller(
      dynamic transactionId) async {
    try {
      final response = await http.get(
        Uri.parse("${baseUrlSalv}seller-transaction/update/${transactionId}"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': await AuthService().getToken(),
        },
      );
      print("PRINT: ${response.body}");
      return AksiTransaksiSeller.fromJson(json.decode(response.body));
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> createTransaksi(JualLimbahForm jualLimbahForm) async {
    try {
      final response =
          await http.post(Uri.parse("${baseUrlSalv}seller-transaction"),
              headers: {
                'Content-Type': 'application/json',
                'Authorization': await AuthService().getToken(),
              },
              body: jsonEncode(jualLimbahForm.toJson()));

      return JualLimbah.fromJson(json.decode(response.body));
    } catch (e) {
      rethrow;
    }
  }
}
