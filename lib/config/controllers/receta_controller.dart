import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../features/shared/infrastructure/input/appp.dart';
import 'api.dart';

class RecetaController {
  Future getRecetas() async {
    SharedPreferences user = await SharedPreferences.getInstance();
    int id = user.getInt('id') ?? 0;
    String token = user.getString('token') ?? '';
    var response = await http.get(
      Uri.parse('$apiUrl/recetasMedicasUser/$id'),
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
        List<Map<String, dynamic>> recetas = [];
        for (var item in data) {
          recetas.add(item);
        }
        /* if (kDebugMode) {
          print(citas);
        } */
        return recetas;
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
