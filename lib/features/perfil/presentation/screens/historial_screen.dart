import 'package:Clinica_ERP/config/controllers/controllers_Doctors/historia_clinica_controller.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Clinica_ERP/config/controllers/historial_controller.dart';

import '../../../shared/widgets/side_menu.dart';

class HistorialClinicoScreeen extends StatefulWidget {
  const HistorialClinicoScreeen({super.key});

  @override
  State<HistorialClinicoScreeen> createState() =>
      _HistorialClinicoScreeenState();
}

class _HistorialClinicoScreeenState extends State<HistorialClinicoScreeen> {
  List<dynamic> historialClinico = [];
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String nameUser = '';
  String emailUser = '';

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
  void initState() {
    // TODO: implement initState
    getDatosUser();
    HistoriaClinicaController().getHistoriaClinicaDoctor().then((value) {
      setState(() {
        historialClinico = value;
      });
    });
    super.initState();
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
        title: const Text('Historial Clinico'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded))
        ],
      ),
      body: _HistorialClinicoView(historialClinico: historialClinico),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Nueva Historia Clinica'),
        icon: const Icon(Icons.add),
        onPressed: () {
          /* GoRouter.of(context).go('/citaCreate'); */
          //appRouter.go('/citaCreate');
        },
      ),
    );
  }
}

class _HistorialClinicoView extends StatelessWidget {
  const _HistorialClinicoView({
    Key? key,
    required this.historialClinico,
  }) : super(key: key);
  final List<dynamic> historialClinico;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: historialClinico.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12, blurRadius: 5, offset: Offset(0, 5))
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Fecha: ${historialClinico[index]['fechaRegistro']}",
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Enfermedad: ${historialClinico[index]['enfermedad']}",
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Estado: ${historialClinico[index]['estadoPaciente']}",
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Manifestaciones: ${historialClinico[index]['manifestaciones']}",
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Codigo Expediente: ${historialClinico[index]['expediente']['codigoRegistro']}",
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Fecha Expediente: ${historialClinico[index]['expediente']['fechaRegistro']}",
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ],
          ),
        );
      },
    );
  }
}
