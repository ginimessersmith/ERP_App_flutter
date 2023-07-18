import 'dart:convert';
import 'dart:io';

import 'package:dotenv/dotenv.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:Clinica_ERP/config/router/app_router.dart';

import '../../features/shared/infrastructure/input/appp.dart';
import 'api.dart';

class AuthController {
  void login(
      TextEditingController email, TextEditingController password) async {
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      print(email.text + password.text);
      SharedPreferences user = await SharedPreferences.getInstance();
      var response = await http.post(Uri.parse('$apiUrl/auth/login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'email': email.text, 'password': password.text}));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == true) {
          await user.setString('token', data['token']);
          await user.setInt('id', data['data']['id']);
          await user.setString('name', data['data']['name']);
          await user.setString('email', data['data']['email']);
          await user.setInt('isDoctor', data['data']['isDoctor']);
          int isDoctor = user.getInt('isDoctor') ?? 0;
          print(data['data']['id']);
          if (isDoctor == 1) {
            appRouter.go('/perfil_doctor');
          } else {
            appRouter.go('/perfil');
          }
        } else {
          print('error de password o email');
        }
      } else {
        print('error de validacion o del backend');
      }
    } else {
      print('error del if');
    }
  }
}
