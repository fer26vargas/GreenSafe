import 'dart:convert';
import 'package:flutter/material.dart';
import '../Models/RecyclerModel.dart';
import '../SeccionReciclador/inicioReciclador.dart';
import 'DocumentoIdentidad.dart';
import 'RegistroBascula.dart';
import 'RegistroCredenciales.dart';
import 'RegistroTransporteRecolector.dart';
import 'RegistroInformacionPersonal.dart';
import 'package:http/http.dart' as http;

class RegistroReciclador extends StatefulWidget {
  @override
  _RegistroRecicladorState createState() => _RegistroRecicladorState();
}

class _RegistroRecicladorState extends State<RegistroReciclador> {
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
          SizedBox(height: 10),
          buildButton('Información Personal', context),
          buildButton('Documento de Identidad', context),
          buildButton('Transporte Recolector', context),
          buildButton('Báscula', context),
          buildButton('Registro de credenciales', context),
          Expanded(
              child: SizedBox()), // Espacio expandible para el botón inferior
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
          if (text == 'Información Personal') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RegistroInformacionPersonal(),
              ),
            );
          } else if (text == 'Documento de Identidad') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DocumentoDeIdentidad(),
              ),
            );
          } else if (text == 'Transporte Recolector') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RegistroTransporteRecolector(),
              ),
            );
          } else if (text == 'Báscula') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RegistroBascula(),
              ),
            );
          } else if (text == 'Registro de credenciales') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RegistroCredenciales(),
              ),
            );
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
        onPressed: () {
          RegisterRecycler();
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(15),
          primary: Colors.green[900],
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

  Future<bool> RegisterRecycler() async {
    final recyclerModel = RecyclerModel.instance;

    print('Datos enviados: ${recyclerModel.recycler.toJson()}');

    const apiUrl =
        'https://d2d1-191-104-228-171.ngrok-free.app/RegisterRecycler';
    final uri = Uri.parse(apiUrl);

    try {
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(recyclerModel.recycler.toJson()),
      );

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => InicioPrincipalReciclador()),
        );
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('error: $e');
      return false;
    }
  }
}
