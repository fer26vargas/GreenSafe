import 'dart:io';
import 'package:flutter/material.dart';
import '../Camara/Camara.dart';
import 'dart:convert';

class RegistroTransporteRecolector extends StatefulWidget {
  @override
  _RegistroTransporteRecolectorState createState() => _RegistroTransporteRecolectorState();
}

class _RegistroTransporteRecolectorState extends State<RegistroTransporteRecolector> {
  String? _vehiculoImageBase64;
  String? _numeroPlaca;


  Future<void> _convertAndSetFrontalImage(File imageFile) async {
    List<int> imageBytes = await imageFile.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    setState(() {
      _vehiculoImageBase64 = base64Image;
    });
    print(_vehiculoImageBase64);
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
            SizedBox(height: 15),
            _buildFormField('Número de placa'),
            SizedBox(height: 15),
            Text(
              'Foto del Vehiculo Recolector',
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
              child: _vehiculoImageBase64 != null
                  ? Image.memory(
                      base64Decode(_vehiculoImageBase64!),
                    )
                  : Image.asset('assets/camara.png'),
            ),
            SizedBox(height: 5),
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

  Widget _buildFormField(String labelText) {
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
            onChanged: (value) {
              setState(() {
                _numeroPlaca = value;
                print('Número de placa: $_numeroPlaca');
              });
            },
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

  void _saveFormData() {
    // Capturar el número de placa
    String numeroPlaca = _numeroPlaca ?? '';

    // Capturar la imagen del vehículo en base64
    String vehiculoImageBase64 = _vehiculoImageBase64 ?? '';

    // Ahora puedes hacer lo que necesites con los datos capturados, como enviarlos a una base de datos, guardarlos localmente, etc.
    // Por ejemplo, podrías imprimirlos para verificar que se capturaron correctamente:
    print('Número de placa: $numeroPlaca');
    print('Imagen del vehículo en base64: $vehiculoImageBase64');

    // Aquí puedes realizar la lógica para guardar los datos en tu base de datos o sistema de almacenamiento.
  }
}
