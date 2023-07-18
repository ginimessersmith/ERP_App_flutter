import 'package:Clinica_ERP/config/controllers/controllers_Doctors/cita_doctor_controller.dart';
import 'package:Clinica_ERP/features/shared/shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  void initState() {
    // TODO: implement initState
    CitaDoctorController().getCitaDoctor().then((value) {
      setState(() {
        citas = value;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenuDoctor(
        scaffoldKey: scaffoldKey,
        name: nameUser,
        email: emailUser,
      ),
      appBar: AppBar(
        title: const Text('Sus citas son:'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded))
        ],
      ),
      body: _CitaDoctorView(
        citasDoctor: citas,
      ),
    );
  }
}

class _CitaDoctorView extends StatelessWidget {
  const _CitaDoctorView({super.key, required this.citasDoctor});
  final List<dynamic> citasDoctor;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: citasDoctor.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.all(6),
            padding: EdgeInsets.all(10),
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
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.amber[200],
                      ),
                      child: const Icon(
                        LineIcons.medicalBook,
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
                        Text('Motivo: ${citasDoctor[index]['motivo']}'),
                        Text('Fecha: ${citasDoctor[index]['fecha']}'),
                        Text(
                            'Paciente: ${citasDoctor[index]['usuario']['name']}'),
                        Text(
                            'Especialidad: ${citasDoctor[index]['especialidad']['nombre']}'),
                        Text(
                            'Consultorio: ${citasDoctor[index]['consultorio']['nro_consultorio']}'),
                        Text(
                            'Turno: ${citasDoctor[index]['consultorio']['turno']['descripcion']}'),
                        Text(
                            'Horario: ${citasDoctor[index]['consultorio']['turno']['horaInicio'].toString().substring(0, 5)} - ${citasDoctor[index]['consultorio']['turno']['horaFin'].toString().substring(0, 5)}')
                      ],
                    ))
                  ],
                )
              ],
            ),
          );
        });
  }
}
