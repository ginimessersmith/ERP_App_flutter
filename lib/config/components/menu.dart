import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class MenuItem {
  final String label;
  final String link;
  final IconData icon;

  MenuItem({
    required this.label,
    required this.link,
    required this.icon,
  });
}

final List<MenuItem> appMenuItems = [
  MenuItem(
    label: 'Gestionar Cita',
    link: '/perfil',
    icon: Icons.home_outlined,
  ),
  MenuItem(
    label: 'Especialidades',
    link: '/especialidades',
    icon: Icons.local_hospital,
  ),
  MenuItem(
    label: 'Doctores',
    link: '/doctores',
    icon: Icons.person,
  ),
  /* Mis recetas */
  MenuItem(
    label: 'Mis recetas',
    link: '/recetas',
    icon: Icons.receipt_long,
  ),
  /* Historial Clinico */
  MenuItem(
    label: 'Historial Clinico',
    link: '/historial',
    icon: LineIcons.medicalFile,
  ),
];
