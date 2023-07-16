import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../shared/widgets/side_doctor_menu.dart';

class HistorialClinicoDoctor extends StatefulWidget {
  const HistorialClinicoDoctor({super.key});

  @override
  State<HistorialClinicoDoctor> createState() => _HistorialClinicoDoctorState();
}

class _HistorialClinicoDoctorState extends State<HistorialClinicoDoctor> {
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
      body: Text('aqui vendra el historial clinico del doctor'),
    );
  }
}
