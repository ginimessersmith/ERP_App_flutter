import 'dart:ffi';

import 'package:Clinica_ERP/config/controllers/consultorio_user.dart';
import 'package:Clinica_ERP/features/shared/shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConsultorioUserScreen extends StatefulWidget {
  const ConsultorioUserScreen({super.key});

  @override
  State<ConsultorioUserScreen> createState() => _ConsultorioUserScreenState();
}

class _ConsultorioUserScreenState extends State<ConsultorioUserScreen> {
  List<dynamic> consultorio = [];
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String nameUser = '';
  String emailUser = '';

  @override
  void initState() {
    ConsultorioUserController().getConsultorioUser().then((consultUs) {
      setState(() {
        consultorio = consultUs;
      });
    });
    getDatosUser();
    super.initState();
  }

  void getDatosUser() async {
    SharedPreferences user = await SharedPreferences.getInstance();
    String name = user.getString('name') ?? '';
    String email = user.getString('email') ?? '';
    setState(() {
      nameUser = nameUser;
      emailUser = email;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(
        scaffoldKey: scaffoldKey,
        name: nameUser,
        email: emailUser,
      ),
      appBar: AppBar(
        title: const Text('Consultorios'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded))
        ],
      ),
      body: _ConsultorioUser(consultorios: consultorio),
    );
  }
}

class _ConsultorioUser extends StatelessWidget {
  const _ConsultorioUser({super.key, required this.consultorios});
  final List<dynamic> consultorios;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: consultorios.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black, blurRadius: 5, offset: Offset(0, 5))
              ]),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.amber[50]),
                    child: const Icon(
                      LineIcons.medicalNotes,
                      size: 50,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Numero de Consultorio: ${consultorios[index]['nro_consultorio']}'),
                      Text(
                          'Doctor en turno: ${consultorios[index]['doctor']['cargo']}'),
                      Text(
                          'Horario: ${consultorios[index]['turno']['descripcion']} '),
                      Text(
                          'desde ${consultorios[index]['turno']['horaInicio'].toString().substring(0, 5)} hasta ${consultorios[index]['turno']['horaFin'].toString().substring(0, 5)}')
                    ],
                  ))
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
