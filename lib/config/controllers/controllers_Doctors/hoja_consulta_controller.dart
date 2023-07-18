import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../features/shared/infrastructure/input/appp.dart';
import '../api.dart';

class HojaConsultaController {
  Future getHojaConsultaDoctor() async {
    SharedPreferences user = await SharedPreferences.getInstance();
    String token = user.getString('token') ?? '';
    int id = user.getInt('id') ?? 0;
    var response = await http.get(Uri.parse('$apiUrl/hojaConsulta/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });

    if (response.statusCode == 200) {
      try {
        var data = jsonDecode(response.body);
        List<Map<String, dynamic>> hojaConsulta = [];
        for (var item in data) {
          hojaConsulta.add(item);
        }
        print(hojaConsulta);
        return hojaConsulta;
      } catch (e) {
        print('error en tratamiento controller decode json : $e');
        return [];
      }
    } else {
      print('error en tratamiento controller, status code no 200');
    }
  }

  void deleteHojaConsultaDoctor(id) async {
    SharedPreferences user = await SharedPreferences.getInstance();
    String token = user.getString('token') ?? '';

    var response = await http.delete(Uri.parse('$apiUrl/hojaConsulta/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });

    if (response.statusCode == 200) {
      try {
        var data = jsonDecode(response.body);
        print(data);
      } catch (e) {
        print('Error hoja consulta controller decodign json $e');
      }
    } else {
      print('Erro hoja consulta controller status code no 200');
    }
  }
}
