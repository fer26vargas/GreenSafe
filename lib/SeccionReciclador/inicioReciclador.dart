import 'package:flutter/material.dart';

class InicioPrincipalReciclador extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio Principal Reciclador'),
      ),
      body: Center(
        child: Text(
          'Inicio Principal Reciclador',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
