import 'package:flutter/material.dart';
import 'package:visual1/RegistroReciclador/RegistroBascula.dart';
import 'package:visual1/RegistroReciclador/RegistroTransporteRecolector.dart';
import 'DocumentoIdentidad.dart';
import 'RegistroInformacionPersonal.dart';

class RegistroReciclador extends StatefulWidget {
  @override
  _RegistroRecicladorState createState() => _RegistroRecicladorState();
}

class _RegistroRecicladorState extends State<RegistroReciclador> {
  bool camposCompletos = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: Text(
          'Verificación',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 10), // Separación desde la parte superior
          buildButton('Información Personal', context), // Aquí paso el contexto
          buildButton('Documento de Identidad',context), //
          buildButton('Transporte Recolector',context), //
          buildButton('Báscula',context), //
          Expanded(child: SizedBox()), // Espacio expandible para el botón inferior
          buildSendButton(),
        ],
      ),
    );
  }

  Widget buildButton(String text, BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: () {
          // Lógica del botón
          if (text == 'Información Personal') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegistroInformacionPersonal()), 
            );
          } else if (text == 'Documento de Identidad') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DocumentoDeIdentidad()), 
            );
          } else if (text == 'Transporte Recolector') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegistroTransporteRecolector()), 
            );
          } else if (text == 'Báscula') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegistroBascula()), 
            );
          } else {
            setState(() {
              camposCompletos = !camposCompletos;
            });
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54, 
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward,
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }


  Widget buildSendButton() {
    return Container(
      margin: EdgeInsets.all(10),
      width: double.infinity, 
      child: ElevatedButton(
        onPressed: camposCompletos ? () {} : null,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(15),
          primary: camposCompletos ? Colors.green[900] : Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          'Enviar',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

