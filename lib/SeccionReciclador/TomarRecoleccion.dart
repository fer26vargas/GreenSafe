import 'package:flutter/material.dart';
import '../Widgets/BarraNavegacionReciclador.dart';
import '../Widgets/RecoleccionCard.dart';

class TomarRecolecciones extends StatelessWidget {
  final List<Map<String, String>> recolecciones = [
    {"name": "Johan Hernan", "address": "Carrera 8 #9 - 38 Andes", "imageUrl": "assets/avatar.png"},
    // Add more items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recolecciones Disponibles'),
        backgroundColor: Colors.green[900],
      ),
      body: ListView.builder(
        itemCount: recolecciones.length,
        itemBuilder: (context, index) {
          return RecoleccionCardWidget(
            name: recolecciones[index]["name"]!,
            address: recolecciones[index]["address"]!,
            imageUrl: recolecciones[index]["imageUrl"]!,
            onAccept: () {
              // Handle accept logic
            },
            onReject: () {
              // Handle reject logic
            },
          );
        },
      ),
      bottomNavigationBar: BarraNavegacionReciclador(),
    );
  }
}
