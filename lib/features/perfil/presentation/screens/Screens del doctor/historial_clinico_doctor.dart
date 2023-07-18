import 'package:Clinica_ERP/config/controllers/controllers_Doctors/historia_clinica_controller.dart';
import 'package:Clinica_ERP/features/perfil/presentation/screens/Screens%20del%20doctor/create_historial.dart';
import 'package:Clinica_ERP/features/perfil/presentation/screens/Screens%20del%20doctor/edit_historial.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../shared/widgets/side_doctor_menu.dart';

class HistorialClinicoDoctor extends StatefulWidget {
  const HistorialClinicoDoctor({super.key});

  @override
  State<HistorialClinicoDoctor> createState() => _HistorialClinicoDoctorState();
}

class _HistorialClinicoDoctorState extends State<HistorialClinicoDoctor> {
  List<dynamic> historialClinicoDoctor = [];
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String nameUser = '';
  String emailUser = '';

  @override
  void initState() {
    // TODO: implement initState
    HistoriaClinicaController().getHistoriaClinicaDoctor().then((value) {
      setState(() {
        historialClinicoDoctor = value;
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
      nameUser = name;
      emailUser = email;
    });
  }

  void deleteHistorialClinico(int index) async {
    HistoriaClinicaController()
        .deleteHistoriaClinicaDoctor(historialClinicoDoctor[index]['id']);
    setState(() {
      historialClinicoDoctor.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenuDoctor(
        scaffoldKey: scaffoldKey,
        name: nameUser,
        email: emailUser,
      ),
      appBar: AppBar(
        title: const Text('Historial Clinico'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded))
        ],
      ),
      body: _HistorialClinico(
        historialClinico: historialClinicoDoctor,
        onDelete: deleteHistorialClinico,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateHistorialClinico(),
            ),
          );
        },
        label: Text('Nueva Historial Clinico'),
      ),
    );
  }
}

class _HistorialClinico extends StatelessWidget {
  const _HistorialClinico(
      {super.key, required this.historialClinico, required this.onDelete});
  final List<dynamic> historialClinico;
  final Function(int) onDelete;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: historialClinico.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: const EdgeInsets.all(6),
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
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Paciente: ${historialClinico[index]['usuario']['name']}'),
                      Text(
                          'Enfermedad: ${historialClinico[index]['enfermedad']}'),
                      Text(
                          'Manifestaciones: ${historialClinico[index]['manifestaciones']}'),
                      Text(
                          'Fecha de Registro: ${historialClinico[index]['fechaRegistro']}'),
                      Text(
                          'Estado Paciente: ${historialClinico[index]['estadoPaciente']}'),
                    ],
                  )),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditHistorialClinico(
                            idHistorial: historialClinico[index]['id'],
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.edit),
                    color: Colors.blue,
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
