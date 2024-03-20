import 'dart:io';
import 'package:flutter/material.dart';
import '../Camara/Camara.dart';
import 'dart:convert';

class RegistroBascula extends StatefulWidget {
  @override
  _RegistroBasculaState createState() => _RegistroBasculaState();
}

class _RegistroBasculaState extends State<RegistroBascula> {
  String? _basculaImageBase64;

  Future<void> _convertAndSetFrontalImage(File imageFile) async {
    List<int> imageBytes = await imageFile.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    setState(() {
      _basculaImageBase64 = base64Image;
    });
    print(_basculaImageBase64);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: Text(
          'Cédula de Ciudadanía',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 45),
            Text(
              'Foto de la báscula',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            Container(
              width: 200,
              height: 200,
              color: Colors.grey[200],
              child: Center(
                child: _basculaImageBase64 != null
                    ? Image.memory(
                        base64Decode(_basculaImageBase64!),
                      )
                    : Image.asset('assets/camara.png'),
              ),
            ),
            SizedBox(height: 10), // Espacio adicional
            ElevatedButton(
              onPressed: () async {
                final imagePath = await Navigator.push<String>(
                  context,
                  MaterialPageRoute(builder: (context) => Camera()),
                );
                if (imagePath != null) {
                  File selectedImage = File(imagePath);
                  await _convertAndSetFrontalImage(selectedImage);
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green[900],
                minimumSize: Size(150, 25),
              ),
              child: Text(
                'Añadir',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 10), 
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 45), // Ajusta el margen horizontal según sea necesario
              child: Text(
                'Para poder realizar una recolección satisfactoria, es necesario tener una báscula que te permita llevar el control del peso de los residuos recogidos.',
                textAlign: TextAlign.center, 
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(20),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              _saveFormData(); // Acción para guardar los datos
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

  void _saveFormData() {
    String basculaImageBase64 = _basculaImageBase64 ?? '';
    print('Imagen de la báscula en base64: $basculaImageBase64');
  }
}
