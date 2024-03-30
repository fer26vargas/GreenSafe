import 'package:flutter/material.dart';
import '../SeccionUsuarios/EditarPerfil.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 25, horizontal: 12),
      constraints: BoxConstraints(minHeight: 0),
      child: ListView(
        shrinkWrap: true, // Para hacer que el ListView se adapte al contenido
        physics: NeverScrollableScrollPhysics(), // Para deshabilitar el desplazamiento del ListView
        children: [
          _buildMenuItem(context, Icons.people, '¿Quiénes Somos?', () {
            // Navigator.push(context, MaterialPageRoute(builder: (context) => QuienesSomos()));
          }),
          SizedBox(height: 16),
          _buildMenuItem(context, Icons.delete, '¿Cómo Reciclar?', () {
            // Navigator.push(context, MaterialPageRoute(builder: (context) => ComoReciclar()));
          }),
          SizedBox(height: 16),
          _buildMenuItem(context, Icons.schedule, 'Programar Recolección', () {
            // Navigator.push(context, MaterialPageRoute(builder: (context) => ProgramarRecoleccion()));
          }),
          SizedBox(height: 16),
          _buildMenuItem(context, Icons.cancel, 'Cancelaciones', () {
            // Navigator.push(context, MaterialPageRoute(builder: (context) => Cancelaciones()));
          }),
          SizedBox(height: 16),
          _buildMenuItem(context, Icons.edit, 'Editar Perfil', () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => EditarPerfil()));
          }),
          SizedBox(height: 16),
          _buildMenuItem(context, Icons.exit_to_app, 'Cerrar Sesión', () {
            // Navigator.push(context, MaterialPageRoute(builder: (context) => CerrarSesion()));
          }),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String text, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        children: [
          Icon(icon),
          SizedBox(width: 15),
          Text(
            text,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
