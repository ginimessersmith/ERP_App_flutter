import 'package:Clinica_ERP/config/controllers/controllers_Doctors/tratamiento_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../shared/widgets/side_doctor_menu.dart';

class Tratamiento extends StatefulWidget {
  const Tratamiento({super.key});

  @override
  State<Tratamiento> createState() => _TratamientoState();
}

class _TratamientoState extends State<Tratamiento> {
  List<dynamic> tratamientoDoctor = [];
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String nameUser = '';
  String emailUser = '';

  @override
  void initState() {
    // TODO: implement initState
    TratamientoController().getTratamientoDoctor().then((value) {
      setState(() {
        tratamientoDoctor = value;
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

  void deleteTratamiento(int index) async {
    TratamientoController().deleteTratamiento(tratamientoDoctor[index]['id']);
    setState(() {
      tratamientoDoctor.removeAt(index);
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
      body: _TratamientoView(
        tratamientos: tratamientoDoctor,
        onDelete: deleteTratamiento,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text('Nueva Tratamiento'),
      ),
    );
  }
}

class _TratamientoView extends StatelessWidget {
  const _TratamientoView(
      {super.key, required this.tratamientos, required this.onDelete});

  final List<dynamic> tratamientos;
  final Function(int) onDelete;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tratamientos.length,
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
                          'Paciente: ${tratamientos[index]['paciente']['name']}'),
                      Text(
                          'Descripcion: ${tratamientos[index]['descripcion']}'),
                      Text('Sintoma: ${tratamientos[index]['nombre']}'),
                      Text(
                          'Duracion del tratamiento: ${tratamientos[index]['duracion']}'),
                      Text(
                          'Medicamento: ${tratamientos[index]['medicamento']['descripcion']}'),
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
