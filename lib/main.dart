import 'package:flutter/material.dart';
import 'package:visual1/RegistroReciclador/RegistroInformacionPersonal.dart';
import 'package:visual1/SeccionUsuarios/EditarPerfil.dart';
import 'package:visual1/SeccionUsuarios/vistaPrincipal.dart';
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
      home: VistaPrincipal(),
    );
  }
}
