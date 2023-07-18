import 'dart:convert';

import 'package:Clinica_ERP/config/controllers/api.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../features/shared/infrastructure/input/appp.dart';

class ConsultorioDoctorController {
  Future getConsultorioDoctor() async {
    SharedPreferences user = await SharedPreferences.getInstance();
    int id = user.getInt('id') ?? 0;
    String token = user.getString('token') ?? '';

    var response = await http.get(Uri.parse('$apiUrl/consultorioDoctor/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });
    if (response.statusCode == 200) {
      try {
        var data = jsonDecode(response.body);
        List<Map<String, dynamic>> consultorioDoctor = [];
        for (var item in data) {
          consultorioDoctor.add(item);
        }
        return consultorioDoctor;
      } catch (e) {
        print('erro decoding consultorio doctor $e');
        return [];
      }
    } else {
      print('error status code no 200 consultorio doctor controller');
      return [];
    }
  }
}
