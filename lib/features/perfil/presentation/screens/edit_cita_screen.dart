import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Clinica_ERP/features/perfil/presentation/screens/products_screen.dart';

import '../../../../config/controllers/cita_controller.dart';
import '../../../../config/router/app_router.dart';

class EditCitaScreen extends StatefulWidget {
  const EditCitaScreen({super.key, required this.idCita});
  final int idCita;

  @override
  State<EditCitaScreen> createState() => _EditCitaScreenState();
}

class _EditCitaScreenState extends State<EditCitaScreen> {
  List<dynamic> consultas = [];
  List<dynamic> especialidades = [];
  int idConsulta = 0;
  int idEspecialidad = 0;
  String motivo = '';
  DateTime fecha = DateTime.now();
  String fechaString = '';

  String nameUser = '';
  String emailUser = '';

  final motivoController = TextEditingController();

  /* Selecionar Fecha */
  Future<void> seleccionarFecha() async {
    final DateTime? fechaSeleccionada = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (fechaSeleccionada != null) {
      setState(() {
        fecha = fechaSeleccionada;
        fechaString = DateFormat('yyyy-MM-dd').format(fechaSeleccionada);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    CitaController().getCita(widget.idCita).then((value) async {
      setState(() {
        var cita = value;
        if (kDebugMode) {
          print(cita);
        }
        motivo = cita['motivo'];
        fechaString = cita['fecha'];
        idConsulta = cita['idConsulta'];
        idEspecialidad = cita['idEspecialidad'];

        motivoController.text = motivo;
      });
    });

    CitaController().getConsultas().then((value) {
      setState(() {
        consultas = value;
        /* idConsulta = consultas[0]['id']; */
        /* print(consultas); */
        print(consultas.length);
      });
    });
    CitaController().getEspecialidades().then((value) {
      setState(() {
        especialidades = value;
        /* idEspecialidad = especialidades[0]['id']; */
        /* print(especialidades); */
        print(especialidades.length);
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
        title: const Text('Editar Cita'),
        /* Back */
        leading: IconButton(
          onPressed: () {
            /* appRouter.go('/perfil'); */
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PerfilScreen(),
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
                    'Seleccione la consulta',
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
                        value: idConsulta,
                        onChanged: (value) {
                          setState(() {
                            idConsulta = value as int;
                          });
                        },
                        items: consultas.map((consulta) {
                          return DropdownMenuItem(
                            value: consulta['id'],
                            child: Text(
                              consulta['descripcion'],
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
                    'Seleccione la especialidad',
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
                        value: idEspecialidad,
                        onChanged: (value) {
                          setState(() {
                            idEspecialidad = value as int;
                          });
                        },
                        items: especialidades.map((especialidad) {
                          return DropdownMenuItem(
                            value: especialidad['id'],
                            child: Text(especialidad['nombre'],
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 15)),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Motivo',
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
                      controller: motivoController,
                      onChanged: (value) {
                        setState(() {
                          motivo = value;
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
                  Text("Fecha seleccionada: $fechaString"),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          CitaController().updateCita(
                            widget.idCita,
                            motivo,
                            fechaString,
                            idConsulta,
                            idEspecialidad,
                            context,
                          );
                        },
                        child: const Text('Editar Cita')),
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
