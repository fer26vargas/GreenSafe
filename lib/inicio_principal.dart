import 'package:flutter/material.dart';

import 'RegistroReciclador/RegistroReciclador.dart';
import 'RegistroUser/RegistroUsario.dart';
import 'inicio_sesion.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  CustomButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF316C09)),
        minimumSize: MaterialStateProperty.all<Size>(const Size(250, 40)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: const BorderSide(color: Color(0xFF316C09), width: 6),
          ),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class InicioPrincipal extends StatelessWidget {
  const InicioPrincipal({Key? key}) : super(key: key);

  void _mostrarModalRegistro(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Registro',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              CustomButton(
                text: 'Usuario',
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegistroUsuario()),
                );
                },
              ),
              const SizedBox(height: 10),
              CustomButton(
                text: 'Reciclador',
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegistroReciclador()),
                );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/logo.png',
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 120),
            CustomButton(
              text: 'Registrarse',
              onPressed: () {
                _mostrarModalRegistro(context);
              },
            ),
            const SizedBox(height: 10),
            CustomButton(
              text: 'Iniciar Sesión',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InicioSesion()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
