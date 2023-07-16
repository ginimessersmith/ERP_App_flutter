import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Clinica_ERP/config/router/app_router.dart';
import 'package:Clinica_ERP/features/shared/shared.dart';
import '../../../config/components/menuDoctor.dart';

class SideMenuDoctor extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  SideMenuDoctor({
    Key? key,
    required this.scaffoldKey,
    required this.name,
    required this.email,
  }) : super(key: key);

  String name;
  String email;

  @override
  State<SideMenuDoctor> createState() => _SideMenuDoctorState();
}

class _SideMenuDoctorState extends State<SideMenuDoctor> {
  int navDrawerIndex = 0;

  void logout() async {
    SharedPreferences user = await SharedPreferences.getInstance();
    await user.clear();
  }

  @override
  Widget build(BuildContext context) {
    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;
    final textStyles = Theme.of(context).textTheme;

    return NavigationDrawer(
      elevation: 1,
      selectedIndex: navDrawerIndex,
      onDestinationSelected: (value) {
        setState(() {
          navDrawerIndex = value;
        });

        final menuDoctorItem = appMenuDoctorItems[value];
        GoRouter.of(context).go(menuDoctorItem.link);
        widget.scaffoldKey.currentState?.closeDrawer();
      },
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20, hasNotch ? 0 : 20, 16, 0),
          child: Text(widget.name, style: textStyles.titleMedium),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 16, 10),
          child: Text(widget.email, style: textStyles.titleSmall),
        ),
        for (var menuDoctorItem in appMenuDoctorItems)
          ListTile(
            leading: Icon(menuDoctorItem.icon),
            title: Text(menuDoctorItem.label),
            onTap: () {
              setState(() {
                navDrawerIndex = appMenuDoctorItems.indexOf(menuDoctorItem);
              });
              widget.scaffoldKey.currentState?.openEndDrawer();
              // Realiza la navegación a la ruta deseada aquí
              GoRouter.of(context).go(menuDoctorItem.link);
            },
          ),
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
          child: Divider(),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 10, 16, 10),
          child: Text('Otras opciones'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomFilledButton(
            onPressed: () {
              logout();
              appRouter.go('/login');
            },
            text: 'Cerrar sesión',
          ),
        ),
      ],
    );
  }
}
