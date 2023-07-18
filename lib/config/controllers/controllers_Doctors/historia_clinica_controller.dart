import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../features/shared/infrastructure/input/appp.dart';
import '../../router/app_router.dart';
import '../api.dart';

class HistoriaClinicaController {
  Future getHistoriaClinicaDoctor() async {
    SharedPreferences user = await SharedPreferences.getInstance();
    String token = user.getString('token') ?? '';
    int id = user.getInt('id') ?? 0;
    var response = await http
        .get(Uri.parse('$apiUrl/historiaClinicasDoctor/$id'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode == 200) {
      try {
        var data = jsonDecode(response.body);
        List<Map<String, dynamic>> historiaClinica = [];
        for (var item in data) {
          historiaClinica.add(item);
        }
        print(historiaClinica);
        return historiaClinica;
      } catch (e) {
        print('error en historia clinica controller decode json : $e');
        return [];
      }
    } else {
      print('error en historia clinica controller, status code no 200');
    }
  }

  Future getHistoriaClinicaDoc(id) async {
    SharedPreferences user = await SharedPreferences.getInstance();
    String token = user.getString('token') ?? '';

    var response = await http.get(Uri.parse('$apiUrl/historiaClinicas/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });

    if (response.statusCode == 200) {
      try {
        var data = jsonDecode(response.body);
        return data;
      } catch (e) {
        print(
            'error en historia clinica getHistoriaClinicaDoc controller decode json : $e');
        return [];
      }
    } else {
      print(
          'error en historia clinica getHistoriaClinicaDoc controller, status code no 200');
    }
  }

  void deleteHistoriaClinicaDoctor(id) async {
    SharedPreferences user = await SharedPreferences.getInstance();
    String token = user.getString('token') ?? '';

    var response = await http
        .delete(Uri.parse('$apiUrl/historiaClinicasDoctor/$id'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode == 200) {
      try {
        var data = jsonDecode(response.body);
        print(data);
      } catch (e) {
        print('Error historial clinico controller decodign json $e');
      }
    } else {
      print('Erro historial clinico controller status code no 200');
    }
  }

  void updateHistoriaClinica(
      int id,
      String enfermedad,
      String manifestaciones,
      String fechaRegistro,
      String estadoPaciente,
      int idExpediente,
      int idAdministrativo,
      int idUsuario,
      context) async {
    // "enfermedad": "Fiebre",
    // "manifestaciones": "Fiebre,tos,dolor de garganta y gripe",
    // "fechaRegistro": "2023-07-14",
    // "estadoPaciente": "Estable",
    // "idExpediente": 1,
    // "idAdministrativo": 1,
    // "idUsuario": 6,
    // "idDoctor": 1
    if (enfermedad != '' && fechaRegistro != '' && enfermedad != '') {
      SharedPreferences user = await SharedPreferences.getInstance();
      String token = user.getString('token') ?? '';
      var response = await http.put(
        Uri.parse('$apiUrl/historiaClinicasDoctor/$id'),
        body: {
          'enfermedad': enfermedad,
          'manifestaciones': manifestaciones,
          'fechaRegistro': fechaRegistro,
          "estadoPaciente": estadoPaciente,
          'idExpediente': idExpediente.toString(),
          'idAdministrativo': '1',
          'idUsuario': idUsuario.toString(),
          'idDoctor': user.getInt('id').toString(),
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
          print(data);
          appRouter.go('/historial_doctor');
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => const PerfilScreen(),
          //   ),
          // );
        } catch (e) {
          print('Error decoding JSON: $e');
        }
      } else {
        print('error');
      }
    } else {
      print('error');
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Complete los campos')));
    }
  }

  void createHistorialClinico(
      String enfermedad,
      String manifestaciones,
      String fechaRegistro,
      String estadoPaciente,
      int idExpediente,
      int idAdministrativo,
      int idUsuario,
      context) async {
    if (enfermedad != '' && manifestaciones != '' && fechaRegistro != '') {
      SharedPreferences user = await SharedPreferences.getInstance();
      String token = user.getString('token') ?? '';
      var response = await http.post(
        Uri.parse('$apiUrl/historiaClinicasDoctor'),
        body: {
          'enfermedad': enfermedad,
          'manifestaciones': manifestaciones,
          'fechaRegistro': fechaRegistro,
          "estadoPaciente": estadoPaciente,
          'idExpediente': idExpediente.toString(),
          'idAdministrativo': '1',
          'idUsuario': idUsuario.toString(),
          'idDoctor': user.getInt('id').toString(),
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
          appRouter.go('/historial_doctor');
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

  Future getUsuarios() async {
    SharedPreferences user = await SharedPreferences.getInstance();
    String token = user.getString('token') ?? '';
    var response = await http.get(
      Uri.parse('$apiUrl/users'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      try {
        var data = jsonDecode(response.body);
        List<Map<String, dynamic>> user = [];
        for (var item in data) {
          user.add(item);
        }
        if (kDebugMode) {
          print(user);
        }
        return user;
      } catch (e) {
        print('Error decoding User en historial clinica controller JSON: $e');
        return [];
      }
    } else {
      return [];
    }
  }
}
