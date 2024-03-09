import 'package:flutter/material.dart';
import 'inicio_principal.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Proyecto',
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: Colors.green[900], 
      ),
      home: InicioPrincipal(),
    );
  }
}
