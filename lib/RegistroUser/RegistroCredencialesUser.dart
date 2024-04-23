import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:visual1/Camara/Camara.dart';
import 'package:visual1/Models/UsersModel.dart';
import '../SeccionUsuarios/vistaPrincipal.dart';

class RegistroCredencialesUser extends StatefulWidget {
  @override
  _RegistroCredencialesUserState createState() =>
      _RegistroCredencialesUserState();
}

class _RegistroCredencialesUserState extends State<RegistroCredencialesUser> {
  String? _email;
  String? _password;
  String? _confirmacionPassword;
  String _profileImageBase64 = 'assets/Perfil.png';
  File? _imageFile;

  void _takePicture() async {
    final imagePath = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (context) => Camera()),
    );
    if (imagePath != null) {
      final bytes = await File(imagePath).readAsBytes();
      final base64Image = base64Encode(bytes);
      setState(() {
        _profileImageBase64 = base64Image;
        _imageFile = File(imagePath);
      });
    }
    print("Imagen en Base64: $_profileImageBase64");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                height:
                    60), // Agregar un espacio entre la parte superior y la foto
            GestureDetector(
              onTap: _takePicture,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.green[900]!, width: 5),
                ),
                child: Stack(
                  children: [
                    _imageFile != null
                        ? CircleAvatar(
                            radius: 75,
                            backgroundImage: FileImage(_imageFile!),
                          )
                        : CircleAvatar(
                            radius: 75,
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage('assets/Perfil.png'),
                          ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green[900],
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
                height:
                    15), // Agregar un espacio entre la foto y el campo de texto
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
            onPressed: () async {
              final success = await _saveFormCredenciales();
              if (success) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VistaPrincipal(),
                  ),
                );
              } else {
                // Mostrar un mensaje de error si la creación del usuario falla
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error al crear el usuario'),
                  ),
                );
              }
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

  Widget _buildFormField(String labelText,
      {required Function(String) onChanged}) {
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
              border: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 2,
                    color: Colors.green), // Ancho y color del borde verde
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField(String labelText,
      {required Function(String) onChanged}) {
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
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.green),
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 12),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> _saveFormCredenciales() async {
    final usersModel = UsersModel.instance;
    print("Entrando a guardar");

    try {
      if (_password != null &&
          _confirmacionPassword != null &&
          _email != null &&
          // ignore: unnecessary_null_comparison
          _profileImageBase64 != null) {
        if (_password == _confirmacionPassword) {
          usersModel.users.Email = 'String';
          usersModel.users.Password = 'String';
          usersModel.users.Photo = 'String';

          print('Correo electrónico: $_email');
          print('Contraseña: $_password');
          print('Imagen de perfil en base64: $_profileImageBase64');
          print('Datos enviados: ${usersModel.users.toJson()}');
          const apiUrl = 'http://localhost:5074/Register';
          final uri = Uri.parse(apiUrl);

          final response = await http.post(
            uri,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(usersModel.users.toJson()),
          );

          if (response.statusCode == 200) {
            print('Datos enviados correctamente');
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => VistaPrincipal()),
            );
            return true;
          } else {
            print('Error en la respuesta del servidor: ${response.body}');
            return false;
          }
        } else {
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
          return false;
        }
      } else {
        print('Por favor, completa todos los campos.');
        return false;
      }
    } catch (e) {
      print('Error al enviar los datos: $e');
      return false;
    }
  }
}
