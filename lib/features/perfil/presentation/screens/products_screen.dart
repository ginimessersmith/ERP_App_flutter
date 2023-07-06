import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Clinica_ERP/config/controllers/cita_controller.dart';
import 'package:Clinica_ERP/config/router/app_router.dart';
import 'package:Clinica_ERP/features/perfil/presentation/screens/edit_cita_screen.dart';
import 'package:Clinica_ERP/features/shared/shared.dart';

/* class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      appBar: AppBar(
        title: const Text('Perfil'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded))
        ],
      ),
      body: const _ProductsView(),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Nueva cita'),
        icon: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}

class _ProductsView extends StatelessWidget {
  const _ProductsView();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Eres genial!'));
  }
} */

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({Key? key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  List<dynamic> citas = [];
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String nameUser = '';
  String emailUser = '';

  @override
  void initState() {
    CitaController().getCitas().then((value) {
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

  void deleteCita(int index) {
    CitaController().deleteCita(citas[index]['id']);
    setState(() {
      citas.removeAt(index);
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
        title: const Text('Citas'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded))
        ],
      ),
      body: _ProductsView(citas: citas, onDelete: deleteCita),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Nueva cita'),
        icon: const Icon(Icons.add),
        onPressed: () {
          /* GoRouter.of(context).go('/citaCreate'); */
          appRouter.go('/citaCreate');
        },
      ),
    );
  }
}

class _ProductsView extends StatelessWidget {
  const _ProductsView({Key? key, required this.citas, required this.onDelete})
      : super(key: key);
  final List<dynamic> citas;
  final Function(int) onDelete;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: citas.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Motivo: ${citas[index]['motivo']}"),
                        Text("Fecha: ${citas[index]['fecha']}"),
                        Text(
                            "Doctor: ${citas[index]['consulta']['doctores']['cargo']}"),
                        Text(
                          "Especialidad: ${citas[index]['especialidad']['nombre']}",
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditCitaScreen(
                            idCita: citas[index]['id'],
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.edit_outlined, color: Colors.blue),
                  ),
                  IconButton(
                    onPressed: () {
                      onDelete(index);
                    },
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
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
