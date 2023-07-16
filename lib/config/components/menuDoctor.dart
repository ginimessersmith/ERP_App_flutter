import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class MenuDoctorItem {
  final String label;
  final String link;
  final IconData icon;

  MenuDoctorItem({
    required this.label,
    required this.link,
    required this.icon,
  });
}

final List<MenuDoctorItem> appMenuDoctorItems = [
  MenuDoctorItem(
    label: 'Gestionar Cita del Doctor',
    link: '/perfil_doctor',
    icon: Icons.home_outlined,
  ),
  MenuDoctorItem(
    label: 'Especialidades del doctor',
    link: '/especialidades_doctor',
    icon: Icons.local_hospital,
  ),

  /* Mis recetas */
  MenuDoctorItem(
    label: 'Mis recetas doctor',
    link: '/recetas_doctor',
    icon: Icons.receipt_long,
  ),
  /* Historial Clinico */
  MenuDoctorItem(
    label: 'Historial Clinico doctor',
    link: '/historial_doctor',
    icon: LineIcons.medicalFile,
  ),
];
