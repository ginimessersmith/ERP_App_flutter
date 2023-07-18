import 'package:Clinica_ERP/config/controllers/controllers_Doctors/consultorio_doctor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../shared/widgets/side_doctor_menu.dart';

class ConsultorioDoctor extends StatefulWidget {
  const ConsultorioDoctor({super.key});

  @override
  State<ConsultorioDoctor> createState() => _ConsultorioDoctorState();
}

class _ConsultorioDoctorState extends State<ConsultorioDoctor> {
  List<dynamic> consultorioDoctor = [];
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String nameUser = '';
  String emailUser = '';

  @override
  void initState() {
    // TODO: implement initState
    ConsultorioDoctorController().getConsultorioDoctor().then((value) {
      setState(() {
        consultorioDoctor = value;
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
        title: const Text('Consultorios '),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded))
        ],
      ),
      body: _ConsultorioDoctorView(
        consultorios: consultorioDoctor,
      ),
    );
  }
}

// ignore: unused_element
class _ConsultorioDoctorView extends StatelessWidget {
  const _ConsultorioDoctorView({super.key, required this.consultorios});
  final List<dynamic> consultorios;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: consultorios.length,
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
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.amber),
                      child: const Icon(
                        LineIcons.alternateMedicalChat,
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
                            'Atiende : ${consultorios[index]['doctor']['cargo']}'),
                        Text(
                            'Formacion : ${consultorios[index]['doctor']['formacion']}'),
                        Text(
                            'Nro Consultorio: ${consultorios[index]['nro_consultorio']}'),
                        Text(
                            'Turno : ${consultorios[index]['turno']['descripcion']}'),
                        Text(
                            'Horario: ${consultorios[index]['turno']['horaInicio'].toString().substring(0, 5)} - ${consultorios[index]['turno']['horaFin'].toString().substring(0, 5)}'),
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
