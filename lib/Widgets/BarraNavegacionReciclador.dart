import 'package:flutter/material.dart';

class BarraNavegacionReciclador extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.insights),
            onPressed: () {
              //Navigator.push(
                //context,
                //MaterialPageRoute(builder: (context) => EstadisticasRecolector()),
             // );
            },
          ),
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              // No es necesario hacer nada, ya estamos en la vista principal
            },
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              //Navigator.push(
                //context,
                //MaterialPageRoute(builder: (context) => PerfilReciclador()),
              //);
            },
          ),
        ],
      ),
    );
  }
}
