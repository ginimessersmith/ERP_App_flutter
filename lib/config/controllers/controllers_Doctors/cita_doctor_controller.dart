import 'dart:convert';

import 'package:Clinica_ERP/config/controllers/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../features/shared/infrastructure/input/appp.dart';

class CitaDoctorController {
  Future getCitaDoctor() async {
    SharedPreferences user = await SharedPreferences.getInstance();
    int id = user.getInt('id') ?? 0;
    String token = user.getString('token') ?? '';

    var response = await http.get(
      Uri.parse('$apiUrl/citasDoctor/$id'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      try {
        var data = jsonDecode(response.body);
        List<Map<String, dynamic>> citasDoctor = [];
        for (var items in data) {
          citasDoctor.add(items);
        }
        return citasDoctor;
      } catch (e) {
        print('erro del json');
      }
    } else {
      print('erro el status code no es 200');
    }
  }
}
