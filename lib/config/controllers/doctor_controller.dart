import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'api.dart';

class DoctorController {
  Future getDoctores() async {
    SharedPreferences user = await SharedPreferences.getInstance();
    String token = user.getString('token') ?? '';
    var response = await http.get(
      Uri.parse('$apiURl/doctores'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      try {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        List<Map<String, dynamic>> doctores = [];
        for (var item in data) {
          doctores.add(item);
        }
        return doctores;
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
