import 'package:flutter/material.dart';
import '../Widgets/BarraNavegacionReciclador.dart';
import 'TomarRecoleccion.dart';

class VistaReciclador extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.6,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/inicio.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  //onTap: () {
                  //  // Redirige a la vista de Ruta de Recolección
                  //  Navigator.push(
                  //    context,
                  //    MaterialPageRoute(builder: (context) => VistaRutaRecoleccion()),
                  //  );
                  //},
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.place),
                        SizedBox(width: 10),
                        Text('RUTA DE RECOLECCIÓN'),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TomarRecolecciones()),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.list),
                        SizedBox(width: 10),
                        Text('TOMAR RECOLECCIÓN'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          BarraNavegacionReciclador(),
        ],
      ),
    );
  }
}
