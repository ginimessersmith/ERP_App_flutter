import 'package:Clinica_ERP/features/perfil/presentation/screens/Screens%20del%20doctor/consultorio_doctor.dart';
import 'package:Clinica_ERP/features/perfil/presentation/screens/Screens%20del%20doctor/create_historial.dart';
import 'package:Clinica_ERP/features/perfil/presentation/screens/Screens%20del%20doctor/edit_historial.dart';
import 'package:Clinica_ERP/features/perfil/presentation/screens/Screens%20del%20doctor/historial_clinico_doctor.dart';
import 'package:Clinica_ERP/features/perfil/presentation/screens/Screens%20del%20doctor/hoja_consulta.dart';
import 'package:Clinica_ERP/features/perfil/presentation/screens/Screens%20del%20doctor/perfil_doctor.dart';
import 'package:Clinica_ERP/features/perfil/presentation/screens/Screens%20del%20doctor/recetas_doctor.dart';
import 'package:Clinica_ERP/features/perfil/presentation/screens/Screens%20del%20doctor/tratamiento.dart';
import 'package:Clinica_ERP/features/perfil/presentation/screens/consultorio_user_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:Clinica_ERP/features/auth/auth.dart';
import 'package:Clinica_ERP/features/auth/presentation/screens/guardar_token.dart';
import 'package:Clinica_ERP/features/perfil/presentation/screens/create_cita_screen.dart';
import 'package:Clinica_ERP/features/perfil/presentation/screens/especialidades_screen.dart';
import 'package:Clinica_ERP/features/perfil/presentation/screens/historial_screen.dart';
import 'package:Clinica_ERP/features/perfil/presentation/screens/recetas_screen.dart';
import 'package:Clinica_ERP/features/perfil/products.dart';

import '../../features/perfil/presentation/screens/doctores_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    ///* Auth Routes
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/guardarToken',
      builder: (context, state) => const Token(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),

    ///* Product Routes
    GoRoute(
      path: '/perfil',
      builder: (context, state) => const PerfilScreen(),
    ),

    /* Especialidades */
    GoRoute(
      path: '/especialidades',
      builder: (context, state) => const EspecialidadesScreen(),
    ),

    /* GoRoute(
      path: '/citaCreate',
      builder: (context, state) => const CitaCreateScreen(),
    ), */

    /* Doctores */
    GoRoute(
      path: '/doctores',
      builder: (context, state) => const DoctoresScreen(),
    ),

    /* Mis recetas */
    GoRoute(
      path: '/recetas',
      builder: (context, state) => const RecetasScreen(),
    ),

    /* Hisorial Clinico */
    GoRoute(
      path: '/historial',
      builder: (context, state) => const HistorialClinicoScreeen(),
    ),

    /* Create Cita */
    GoRoute(
      path: '/citaCreate',
      builder: (context, state) => const CreateCitaScreen(),
    ),
    GoRoute(
      path: '/consultorioUser',
      builder: (context, state) => const ConsultorioUserScreen(),
    ),
    //TODO* aqui empiezan las rutas que pertenecen a los user doctores
    GoRoute(
      path: '/perfil_doctor',
      builder: (context, state) => const PerfilDoctor(),
    ),
    GoRoute(
      path: '/recetas_doctor',
      builder: (context, state) => const RecetasDoctor(),
    ),
    GoRoute(
      path: '/historial_doctor',
      builder: (context, state) => const HistorialClinicoDoctor(),
    ),
    GoRoute(
      path: '/consultorio_doctor',
      builder: (context, state) => const ConsultorioDoctor(),
    ),
    GoRoute(
      path: '/hoja_consulta',
      builder: (context, state) => const HojaConsulta(),
    ),
    GoRoute(
      path: '/tratamiento',
      builder: (context, state) => const Tratamiento(),
    ),
    // GoRoute(
    //   path: '/create_historia_clinica',
    //   builder: (context, state) => const CreateHistorialClinico(),
    // ),
  ],

  ///! TODO: Bloquear si no se está autenticado de alguna manera
);
