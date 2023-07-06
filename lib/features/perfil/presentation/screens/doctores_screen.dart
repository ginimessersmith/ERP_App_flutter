import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Clinica_ERP/config/controllers/doctor_controller.dart';

import '../../../shared/widgets/side_menu.dart';

class DoctoresScreen extends StatefulWidget {
  const DoctoresScreen({super.key});

  @override
  State<DoctoresScreen> createState() => _DoctoresScreenState();
}

class _DoctoresScreenState extends State<DoctoresScreen> {
  List<dynamic> doctores = [];
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String nameUser = '';
  String emailUser = '';
  @override
  void initState() {
    // TODO: implement initState
    DoctorController().getDoctores().then((value) {
      setState(() {
        doctores = value;
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
        title: const Text('Doctores'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded))
        ],
      ),
      body: _DoctoresView(doctores: doctores),
    );
  }
}

class _DoctoresView extends StatelessWidget {
  const _DoctoresView({Key? key, required this.doctores}) : super(key: key);

  final List<dynamic> doctores;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: doctores.length,
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
              ),
            ],
          ),
          child: ListTile(
            leading: const Icon(Icons.person),
            title: Text(doctores[index]['cargo']),
            subtitle: Text("Formacion: ${doctores[index]['formacion']}"),
            trailing: Text(doctores[index]['especialidad']['nombre']),
            /* trailing: const Icon(Icons.arrow_forward_ios), */

            /*  onTap: () {
              Navigator.pushNamed(context, '/citas',
                  arguments: doctores[index]['id']);
            }, */
          ),
        );
      },
    );
  }
}
