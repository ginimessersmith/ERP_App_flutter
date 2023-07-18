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
    label: 'Mis Citas',
    link: '/perfil_doctor',
    icon: Icons.home_outlined,
  ),
  /* Mis recetas */
  MenuDoctorItem(
    label: 'Mis recetas',
    link: '/recetas_doctor',
    icon: Icons.receipt_long,
  ),
  /* Historial Clinico */
  MenuDoctorItem(
    label: 'Historial Clinico',
    link: '/historial_doctor',
    icon: LineIcons.medicalFile,
  ),
  MenuDoctorItem(
    label: 'Consultorio',
    link: '/consultorio_doctor',
    icon: LineIcons.info,
  ),
  MenuDoctorItem(
    label: 'Hojas de Consulta',
    link: '/hoja_consulta',
    icon: LineIcons.medicalBriefcase,
  ),
  MenuDoctorItem(
    label: 'Tratamientos',
    link: '/tratamiento',
    icon: LineIcons.medicalNotes,
  ),
];
