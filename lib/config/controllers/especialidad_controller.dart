import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'api.dart';

class EspecialidadController {
  Future getEspecialidades() async {
    SharedPreferences user = await SharedPreferences.getInstance();
    String token = user.getString('token') ?? '';
    var response = await http.get(
      Uri.parse('$apiURl/especialidades'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    /* if (kDebugMode) {
      print(response.body);
    } */
    if (response.statusCode == 200) {
      try {
        var data = jsonDecode(response.body);
        List<Map<String, dynamic>> especialidades = [];
        for (var item in data) {
          especialidades.add(item);
        }
        /* if (kDebugMode) {
          print(citas);
        } */
        return especialidades;
      } catch (e) {
        if (kDebugMode) {
          print('Error decoding JSON: $e');
        }
        return [];
      }
    } else {
      return [];
    }
  }
}
