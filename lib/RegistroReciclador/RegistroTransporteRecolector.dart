import 'dart:io';
import 'package:flutter/material.dart';
import '../Camara/Camara.dart';
import 'dart:convert';

import '../Models/RecyclerModel.dart';
import 'RegistroReciclador.dart';

class RegistroTransporteRecolector extends StatefulWidget {
  @override
  _RegistroTransporteRecolectorState createState() =>
      _RegistroTransporteRecolectorState();
}

class _RegistroTransporteRecolectorState
    extends State<RegistroTransporteRecolector> {
  String? _vehiculoImageBase64;
  String? _numeroPlaca;
  String? _descripcionVehiculo;

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
          'Registro de Vehículo',
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
            _buildFormField('Descripción del vehículo'),
            SizedBox(height: 15),
            Text(
              'Foto del Vehículo Recolector',
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
      bottomNavigationBar: _buildSaveButton(),
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
                if (labelText == 'Número de placa') {
                  _numeroPlaca = value;
                  print('Número de placa: $_numeroPlaca');
                } else if (labelText == 'Descripción del vehículo') {
                  _descripcionVehiculo = value;
                  print('Descripción del vehículo: $_descripcionVehiculo');
                }
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

  Widget _buildSaveButton() {
    return Container(
      margin: EdgeInsets.all(20),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () async {
            var result = await _saveFormTransport();
            if (result == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegistroReciclador()),
              );
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Text('Guardar'),
          ),
        ),
      ),
    );
  }

  Future<int> _saveFormTransport() async {
    final recyclerModel = RecyclerModel.instance;
    print("entrando a guardar");
    try {
      recyclerModel.recycler.Placa = _numeroPlaca ?? '';
      recyclerModel.recycler.DescripcionVehiculo = _descripcionVehiculo ?? '';
      String fotoVehiculo = _vehiculoImageBase64 ?? '';
      String placa = _numeroPlaca ?? '';
      String descripcionVehiculo = _descripcionVehiculo ?? '';

      print('placa: $placa');
      print('Descripcion vehiculo: $descripcionVehiculo');
      print('Imagen frontal en base64: $fotoVehiculo');
      
      print('Imagen frontal en base64: $fotoVehiculo');
      return 1;
    } catch (e) {
      print(e);
      return 0;
    }
  }
}
