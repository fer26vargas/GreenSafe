import 'package:flutter/material.dart';
/*import '../SeccionUsuarios/EstadisticasUsuario.dart';
import '../SeccionUsuarios/PerfilDeUsuario.dart';
import '../SeccionUsuarios/RecoleccionUsuario.dart';*/

class BarraDeNavegacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {
              //Navigator.push(context, MaterialPageRoute(builder: (context) => EstadisticasUsuario()));
            },
            icon: Icon(Icons.insights),
          ),
          IconButton(
            onPressed: () {
              //Navigator.push(context, MaterialPageRoute(builder: (context) => PerfilDeUsuario()));
            },
            icon: Icon(Icons.perm_identity),
          ),
          IconButton(
            onPressed: () {
              //Navigator.push(context, MaterialPageRoute(builder: (context) => RecoleccionUsuario()));
            },
            icon: Icon(Icons.airport_shuttle),
          ),
        ],
      ),
    );
  }
}
