import 'dart:convert';

import 'package:Clinica_ERP/config/controllers/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../features/shared/infrastructure/input/appp.dart';

class RecetaDoctorController {
  //recetasMedicasDoctor/id
  Future getRecetasDoctor() async {
    SharedPreferences user = await SharedPreferences.getInstance();
    String token = user.getString('token') ?? '';
    int id = user.getInt('id') ?? 0;
    var response = await http.get(Uri.parse('$apiUrl/recetasMedicasDoctor/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });

    if (response.statusCode == 200) {
      try {
        var data = jsonDecode(response.body);
        List<Map<String, dynamic>> recetasDoctor = [];
        for (var item in data) {
          recetasDoctor.add(item);
        }
        print(recetasDoctor);
        return recetasDoctor;
      } catch (e) {
        print('erro decode json : $e');
        return [];
      }
    } else {
      print('error, status code no 200');
    }
  }

  void deleteReceta(id) async {
    SharedPreferences user = await SharedPreferences.getInstance();
    //recetasMedicasDoctor/id
    String token = user.getString('token') ?? '';

    var response = await http
        .delete(Uri.parse('$apiUrl/recetasMedicasDoctor/$id'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode == 200) {
      try {
        var data = jsonDecode(response.body);
        print(data);
      } catch (e) {
        print('Error decodign json $e');
      }
    } else {
      print('Erro status code no 200');
    }
  }
}
