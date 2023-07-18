import 'package:Clinica_ERP/config/controllers/historial_controller.dart';
import 'package:Clinica_ERP/config/router/app_router.dart';
import 'package:Clinica_ERP/features/perfil/presentation/screens/Screens%20del%20doctor/historial_clinico_doctor.dart';
import 'package:Clinica_ERP/features/perfil/presentation/screens/Screens%20del%20doctor/perfil_doctor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../config/controllers/controllers_Doctors/historia_clinica_controller.dart';

class CreateHistorialClinico extends StatefulWidget {
  const CreateHistorialClinico({
    super.key,
  });

  @override
  State<CreateHistorialClinico> createState() => _CreateHistorialClinicoState();
}

class _CreateHistorialClinicoState extends State<CreateHistorialClinico> {
  List<dynamic> usuarios = [];
  String enfermedad = '';
  String manifestaciones = '';
  DateTime fechaReg = DateTime.now();
  String fechaRegString = '';
  String estadoPaciente = '';
  int idExp = 1;
  int idAdmin = 1;
  int idUsuario = 0;

  String nameUser = '';
  String emailUser = '';

  final enfermedadController = TextEditingController();
  final manifestacionesController = TextEditingController();
  final estadoPacienteController = TextEditingController();

  Future<void> seleccionarFecha() async {
    final DateTime? fechaSeleccionada = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (fechaSeleccionada != null) {
      setState(() {
        fechaReg = fechaSeleccionada;
        fechaRegString = DateFormat('yyyy-MM-dd').format(fechaSeleccionada);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    HistoriaClinicaController().getUsuarios().then((value) {
      setState(() {
        usuarios = value;
        /* idConsulta = consultas[0]['id']; */
        /* print(consultas); */
        print('usuarios : ${usuarios.length}');
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
      appBar: AppBar(
        title: const Text('Crear Historial'),
        /* Back */
        leading: IconButton(
          onPressed: () {
            /* appRouter.go('/perfil'); */
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HistorialClinicoDoctor(),
              ),
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.9,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Seleccione el paciente',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: const Text('Seleccione'),
                        value: idUsuario,
                        onChanged: (value) {
                          setState(() {
                            idUsuario = value as int;
                          });
                        },
                        items: usuarios.map((usuario) {
                          return DropdownMenuItem(
                            value: usuario['id'],
                            child: Text(
                              usuario['name'],
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 15),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Enfermedad',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey)),
                    child: TextField(
                      controller: enfermedadController,
                      onChanged: (value) {
                        setState(() {
                          enfermedad = value;
                        });
                      },
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Motivo',
                          hintStyle: TextStyle(fontSize: 15)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Manifestaciones',
                    style: TextStyle(fontSize: 20),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey)),
                    child: TextField(
                      controller: manifestacionesController,
                      onChanged: (value) {
                        setState(() {
                          manifestaciones = value;
                        });
                      },
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Manifestaciones',
                          hintStyle: TextStyle(fontSize: 15)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Estado del paciente',
                    style: TextStyle(fontSize: 20),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey)),
                    child: TextField(
                      controller: estadoPacienteController,
                      onChanged: (value) {
                        setState(() {
                          estadoPaciente = value;
                        });
                      },
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Estado del paciente',
                          hintStyle: TextStyle(fontSize: 15)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Fecha',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: seleccionarFecha,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                        child: const Text(
                          'Seleccionar fecha',
                          style: TextStyle(fontSize: 16),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text("Fecha seleccionada: $fechaRegString"),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          HistoriaClinicaController().createHistorialClinico(
                            enfermedad,
                            manifestaciones,
                            fechaRegString,
                            estadoPaciente,
                            1,
                            1,
                            idUsuario,
                            context,
                          );
                          appRouter.go('/historial_doctor');
                        },
                        child: const Text('Crear Historial Clinico')),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
