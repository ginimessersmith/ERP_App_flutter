import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Clinica_ERP/config/router/app_router.dart';
import 'package:Clinica_ERP/features/auth/auth.dart';
import 'package:Clinica_ERP/features/perfil/presentation/screens/products_screen.dart';

class Token extends StatefulWidget {
  const Token({super.key});

  @override
  State<Token> createState() => _TokenState();
}

class _TokenState extends State<Token> {
  bool login = false;

  @override
  void initState() {
    super.initState();
    checkRoute();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void checkRoute() async {
    SharedPreferences user = await SharedPreferences.getInstance();
    String token = user.getString('token') ?? '';

    if (token.isNotEmpty) {
      setState(() {
        login = true;
      });
    } else {
      setState(() {
        login = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (login) {
      return const PerfilScreen();
    } else {
      return const LoginScreen();
    }
  }
}
