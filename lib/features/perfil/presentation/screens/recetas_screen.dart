import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Clinica_ERP/config/controllers/receta_controller.dart';

import '../../../shared/widgets/side_menu.dart';

class RecetasScreen extends StatefulWidget {
  const RecetasScreen({super.key});

  @override
  State<RecetasScreen> createState() => _RecetasScreenState();
}

class _RecetasScreenState extends State<RecetasScreen> {
  List<dynamic> recetas = [];
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
    getDatosUser();
    RecetaController().getRecetas().then((value) {
      setState(() {
        recetas = value;
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
        title: const Text('Recetas'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded))
        ],
      ),
      body: _RecetasView(recetas: recetas),
    );
  }
}

class _RecetasView extends StatelessWidget {
  const _RecetasView({Key? key, required this.recetas}) : super(key: key);
  final List<dynamic> recetas;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: recetas.length,
      itemBuilder: (context, index) {
        return Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0, 5),
                )
              ],
            ),
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  /* Icon */
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      LineIcons.capsules,
                      size: 50,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recetas[index]['medicamento']['descripcion'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        recetas[index]['frecuencia'],
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        recetas[index]['receta'][0]['hoja_consulta']
                            ['indicación'],
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ));
      },
    );
  }
}
