import 'dart:convert';

import 'package:Clinica_ERP/config/controllers/api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ConsultorioUserController {
  Future getConsultorioUser() async {
    SharedPreferences user = await SharedPreferences.getInstance();
    String token = user.getString('token') ?? '';
    int idUser = user.getInt('id') ?? 1;
    var response = await http.get(
      Uri.parse('$apiURl/consultorioUser/$idUser'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      try {
        var data = jsonDecode(response.body);
        List<Map<String, dynamic>> consultorios = [];
        for (var item in data) {
          consultorios.add(item);
        }
        print(data);
        return consultorios;
      } catch (e) {
        print('Error decode JSON');
      }
    } else {
      print('statuCode no es 200');
    }
  }
}
