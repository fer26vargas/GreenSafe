import 'package:flutter/material.dart';

import '../Models/RecyclerModel.dart';
import 'RegistroReciclador.dart';

class RegistroCredenciales extends StatefulWidget {
  @override
  _RegistroCredencialesState createState() => _RegistroCredencialesState();
}

class _RegistroCredencialesState extends State<RegistroCredenciales> {
  String? _email;
  String? _password;
  String? _confirmacionPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: Text(
          'Registro de credenciales',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 15),
            _buildFormField('Correo electrónico', onChanged: (value) {
              setState(() {
                _email = value;
                print('Correo: $_email');
              });
            }),
            SizedBox(height: 15),
            _buildPasswordField('Contraseña', onChanged: (value) {
              setState(() {
                _password = value;
              });
            }),
            SizedBox(height: 15),
            _buildPasswordField('Confirmar Contraseña', onChanged: (value) {
              setState(() {
                _confirmacionPassword = value;
              });
            }),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(20),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              _saveFormCredenciales();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RegistroReciclador(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.green[900],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Text('Guardar'),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormField(String labelText, {required Function(String) onChanged}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          TextFormField(
            onChanged: onChanged,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField(String labelText, {required Function(String) onChanged}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          TextFormField(
            onChanged: onChanged,
            obscureText: true, // Oculta el texto ingresado
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 12),
            ),
          ),
        ],
      ),
    );
  }

  Future<int> _saveFormCredenciales() async {
  final recyclerModel = RecyclerModel.instance;
  print("entrando a guardar");
  try {
    // Validar que ambos campos de contraseña no estén vacíos
    if (_password != null && _confirmacionPassword != null) {
      // Validar que las contraseñas coincidan
      if (_password == _confirmacionPassword) {
        // Guardar los datos si las contraseñas coinciden
        recyclerModel.recycler.Email = _email ?? '';
        recyclerModel.recycler.Password = _password ?? '';
        String Email = _email ?? '';
        String password = _password ?? '';
        print('imagen: $Email, $password');
        return 1;
      } else {
        // Mostrar un mensaje de error si las contraseñas no coinciden
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Las contraseñas no coinciden.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Aceptar'),
                ),
              ],
            );
          },
        );
        return 0;
      }
    } else {
      print('Por favor, completa ambos campos de contraseña.');
      return 0;
    }
  } catch (e) {
    print(e);
    return 0;
  }
}

}
