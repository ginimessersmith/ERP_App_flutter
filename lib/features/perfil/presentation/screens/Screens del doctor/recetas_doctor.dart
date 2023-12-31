import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../config/controllers/controllers_Doctors/receta_doctor_controller.dart';
import '../../../../shared/widgets/side_doctor_menu.dart';

class RecetasDoctor extends StatefulWidget {
  const RecetasDoctor({super.key});

  @override
  State<RecetasDoctor> createState() => _RecetasDoctorState();
}

class _RecetasDoctorState extends State<RecetasDoctor> {
  List<dynamic> recetasDoctor = [];
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String nameUser = '';
  String emailUser = '';
  @override
  void initState() {
    // TODO: implement initState
    RecetaDoctorController().getRecetasDoctor().then((value) {
      setState(() {
        recetasDoctor = value;
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

  void deleteReceta(int index) async {
    RecetaDoctorController().deleteReceta(recetasDoctor[index]['id']);
    setState(() {
      recetasDoctor.removeAt(index);
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
        title: const Text('Sus Recetas son: '),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded))
        ],
      ),
      body: _RecetasDoctorView(
        recetas: recetasDoctor,
        onDelete: deleteReceta,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text('Nueva Receta'),
      ),
    );
  }
}

class _RecetasDoctorView extends StatelessWidget {
  const _RecetasDoctorView(
      {super.key, required this.recetas, required this.onDelete});

  final List<dynamic> recetas;
  final Function(int) onDelete;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: recetas.length,
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
                      Text('Paciente: ${recetas[index]['usuario']['name']}'),
                      Text('Cantidad: ${recetas[index]['catnidad']}'),
                      Text('Dosis: ${recetas[index]['dosis']}'),
                      Text('Frecuencia: ${recetas[index]['frecuencia']}'),
                      Text(
                          'Diagnostico: ${recetas[index]['receta'][0]['hoja_consulta']['diagnostico']}'),
                      Text(
                          'Medicamento: ${recetas[index]['medicamento']['descripcion']}'),
                      Text(
                          'Indicacion: ${recetas[index]['receta'][0]['hoja_consulta']['indicación']}'),
                      Text(
                          'Proxima Consulta: ${recetas[index]['receta'][0]['hoja_consulta']['proximaConsulta']}')
                    ],
                  )),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit),
                    color: Colors.green,
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
