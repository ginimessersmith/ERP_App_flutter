import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Clinica_ERP/config/router/app_router.dart';

import '../../features/perfil/presentation/screens/products_screen.dart';
import 'api.dart';

class CitaController {
  Future getCitas() async {
    SharedPreferences user = await SharedPreferences.getInstance();
    int id = user.getInt('id') ?? 0;
    String token = user.getString('token') ?? '';
    var response = await http.get(
      Uri.parse('$apiURl/citasUser/$id'),
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
        List<Map<String, dynamic>> citas = [];
        for (var item in data) {
          citas.add(item);
        }
        /* if (kDebugMode) {
          print(citas);
        } */
        return citas;
      } catch (e) {
        print('Error decoding JSON: $e');
        return [];
      }
    } else {
      return [];
    }
  }

  Future getCita(id) async {
    SharedPreferences user = await SharedPreferences.getInstance();
    String token = user.getString('token') ?? '';
    var response = await http.get(
      Uri.parse('$apiURl/citas/$id'),
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
        if (kDebugMode) {
          print(data);
        }
        return data;
      } catch (e) {
        print('Error decoding JSON: $e');
        return "";
      }
    } else {
      return "";
    }
  }

  void deleteCita(id) async {
    SharedPreferences user = await SharedPreferences.getInstance();
    String token = user.getString('token') ?? '';
    var response = await http.delete(
      Uri.parse('$apiURl/citas/$id'),
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
        /* appRouter.go('/perfil'); */
        print(data);
      } catch (e) {
        print('Error decoding JSON: $e');
      }
    } else {
      print('error');
    }
  }

  Future getConsultas() async {
    SharedPreferences user = await SharedPreferences.getInstance();
    String token = user.getString('token') ?? '';
    var response = await http.get(
      Uri.parse('$apiURl/consultas'),
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
        List<Map<String, dynamic>> consultas = [];
        for (var item in data) {
          consultas.add(item);
        }
        /* if (kDebugMode) {
          print(consultas);
        } */
        return consultas;
      } catch (e) {
        print('Error decoding JSON: $e');
        return [];
      }
    } else {
      return [];
    }
  }

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
        print('Error decoding JSON: $e');
        return [];
      }
    } else {
      return [];
    }
  }

  void updateCita(int id, String motivo, String fecha, int idConsulta,
      int idEspecialidad, context) async {
    if (motivo != '' && fecha != '') {
      SharedPreferences user = await SharedPreferences.getInstance();
      String token = user.getString('token') ?? '';
      var response = await http.put(
        Uri.parse('$apiURl/citas/$id'),
        body: {
          'motivo': motivo,
          'fecha': fecha,
          'citaConfirmada': 'confirmada',
          'idConsulta': idConsulta.toString(),
          'idEspecialidad': idEspecialidad.toString(),
          'idAdministrativo': '1',
          'idUsuario': user.getInt('id').toString(),
        },
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
          if (kDebugMode) {
            print(data);
          }
          appRouter.go('/perfil');
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => const PerfilScreen(),
          //   ),
          // );
        } catch (e) {
          if (kDebugMode) {
            print('Error decoding JSON: $e');
          }
        }
      } else {
        if (kDebugMode) {
          print('error');
        }
      }
    } else {
      if (kDebugMode) {
        print('error');
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Complete los campos')));
      }
    }
  }

  void createCita(String motivo, String fecha, int idConsulta,
      int idEspecialidad, context) async {
    if (motivo != '' && fecha != '') {
      SharedPreferences user = await SharedPreferences.getInstance();
      String token = user.getString('token') ?? '';
      var response = await http.post(
        Uri.parse('$apiURl/citas'),
        body: {
          'motivo': motivo,
          'fecha': fecha,
          'citaConfirmada': 'confirmada',
          'idConsulta': idConsulta.toString(),
          'idEspecialidad': idEspecialidad.toString(),
          'idAdministrativo': '1',
          'idUsuario': user.getInt('id').toString(),
        },
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
          appRouter.go('/perfil');
          print(data);
        } catch (e) {
          print('Error decoding JSON: $e');
        }
      } else {
        print('error');
      }
    } else {
      /* Show message */
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Complete los campos')));
    }
  }
}
