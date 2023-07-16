import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../shared/widgets/side_doctor_menu.dart';

class ConsultorioDoctor extends StatefulWidget {
  const ConsultorioDoctor({super.key});

  @override
  State<ConsultorioDoctor> createState() => _ConsultorioDoctorState();
}

class _ConsultorioDoctorState extends State<ConsultorioDoctor> {
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
      body: Text('aqui vendra las recetas del doctor'),
    );
  }
}
