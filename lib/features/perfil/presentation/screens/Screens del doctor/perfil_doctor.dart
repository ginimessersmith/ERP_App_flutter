import 'package:Clinica_ERP/features/shared/shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../shared/widgets/side_doctor_menu.dart';

class PerfilDoctor extends StatefulWidget {
  const PerfilDoctor({super.key});

  @override
  State<PerfilDoctor> createState() => _PerfilDoctorState();
}

class _PerfilDoctorState extends State<PerfilDoctor> {
  List<dynamic> citas = [];
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String nameUser = '';
  String emailUser = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenuDoctor(
        scaffoldKey: scaffoldKey,
        name: nameUser,
        email: emailUser,
      ),
      appBar: AppBar(
        title: const Text('hola '),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded))
        ],
      ),
      body: Text('aqui esta el perfil del doctor'),
    );
  }
}
