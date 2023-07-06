import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Clinica_ERP/config/controllers/especialidad_controller.dart';

import '../../../../config/controllers/cita_controller.dart';
import '../../../shared/widgets/side_menu.dart';
import 'package:line_icons/line_icons.dart';

class EspecialidadesScreen extends StatefulWidget {
  const EspecialidadesScreen({super.key});

  @override
  State<EspecialidadesScreen> createState() => _EspecialidadesScreenState();
}

class _EspecialidadesScreenState extends State<EspecialidadesScreen> {
  List<dynamic> especialidades = [];
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String nameUser = '';
  String emailUser = '';

  @override
  void initState() {
    // TODO: implement initState
    EspecialidadController().getEspecialidades().then((value) {
      setState(() {
        especialidades = value;
        if (kDebugMode) {
          print(especialidades);
        }
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
      drawer: SideMenu(
        scaffoldKey: scaffoldKey,
        name: nameUser,
        email: emailUser,
      ),
      appBar: AppBar(
        title: const Text('Especialidades'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded))
        ],
      ),
      body: _ProductsView(especialidades: especialidades),
    );
  }
}

class _ProductsView extends StatelessWidget {
  const _ProductsView({Key? key, required this.especialidades})
      : super(key: key);
  final List<dynamic> especialidades;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: especialidades.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: const EdgeInsets.all(6),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12, blurRadius: 5, offset: Offset(0, 5))
              ]),
          child: Column(
            children: [
              Row(
                children: [
                  /* Icon */
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    child: const Icon(
                      LineIcons.certificate,
                      size: 50,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Nombre: ${especialidades[index]['nombre']}"),
                        Text(
                            "Descripcion: ${especialidades[index]['descripcion']}"),
                        /* Text("Doctor: ${especialidades[index]['doctores']['cargo']}"), */
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
