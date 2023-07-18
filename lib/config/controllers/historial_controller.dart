import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../features/shared/infrastructure/input/appp.dart';
import 'api.dart';

class HistorialClinicoController {
  Future getHistorialClinico(int idHistorial) async {
    SharedPreferences user = await SharedPreferences.getInstance();
    String token = user.getString('token') ?? '';
    int id = user.getInt('id') ?? 0;
    var response = await http.get(
      Uri.parse('$apiUrl/historiaClinicasUser/$id'),
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
        List<Map<String, dynamic>> historialClinico = [];
        for (var item in data) {
          historialClinico.add(item);
        }
        /* if (kDebugMode) {
          print(citas);
        } */
        return historialClinico;
      } catch (e) {
        /* if (kDebugMode) {
          print('Error decoding JSON: $e');
        } */
        return [];
      }
    } else {
      return [];
    }
  }
}
