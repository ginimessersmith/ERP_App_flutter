import 'package:Clinica_ERP/config/controllers/controllers_Doctors/hoja_consulta_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../shared/widgets/side_doctor_menu.dart';

class HojaConsulta extends StatefulWidget {
  const HojaConsulta({super.key});

  @override
  State<HojaConsulta> createState() => _HojaConsultaState();
}

class _HojaConsultaState extends State<HojaConsulta> {
  List<dynamic> hojaConsultaDoctor = [];
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String nameUser = '';
  String emailUser = '';

  @override
  void initState() {
    // TODO: implement initState
    HojaConsultaController().getHojaConsultaDoctor().then((value) {
      setState(() {
        hojaConsultaDoctor = value;
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

  void deleteHojaConsulta(int index) async {
    HojaConsultaController()
        .deleteHojaConsultaDoctor(hojaConsultaDoctor[index]['id']);
    setState(() {
      hojaConsultaDoctor.removeAt(index);
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
        title: const Text('Hojas de Consulta'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded))
        ],
      ),
      body: _HojaConsulta(
        hojaConsulta: hojaConsultaDoctor,
        onDelete: deleteHojaConsulta,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text('Nueva Hoja Consulta'),
      ),
    );
  }
}

class _HojaConsulta extends StatelessWidget {
  const _HojaConsulta(
      {super.key, required this.hojaConsulta, required this.onDelete});
  final List<dynamic> hojaConsulta;
  final Function(int) onDelete;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: hojaConsulta.length,
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
                          'Paciente: ${hojaConsulta[index]['usuario']['name']}'),
                      Text(
                          'Diagnostico: ${hojaConsulta[index]['diagnostico']}'),
                      Text('Indicacion: ${hojaConsulta[index]['indicación']}'),
                      Text(
                          'Proxima Consulta: ${hojaConsulta[index]['proximaConsulta']}'),
                    ],
                  )),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit),
                    color: Colors.blue,
                  ),
                  IconButton(
                    onPressed: () {
                      onDelete(index);
                    },
                    icon: const Icon(Icons.delete_outlined),
                    color: Colors.red,
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
