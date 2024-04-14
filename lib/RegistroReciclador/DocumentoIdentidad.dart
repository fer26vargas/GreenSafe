import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import '../Camara/Camara.dart';
import 'dart:convert';

import '../Models/RecyclerModel.dart';
import 'RegistroReciclador.dart';

class DocumentoDeIdentidad extends StatefulWidget {
  @override
  _DocumentoDeIdentidadState createState() => _DocumentoDeIdentidadState();
}

class _DocumentoDeIdentidadState extends State<DocumentoDeIdentidad> {
  DateTime? _selectedDate;
  String? _frontalImageBase64;
  String? _traseraImageBase64;
  String? _numeroCedula;
  DateTime? _fechaExpedicion;

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
            _buildFormField('Cédula de ciudadanía'),
            SizedBox(height: 15),
            _buildDateFormField('Fecha de Expedición'),
            SizedBox(height: 15),
            Text(
              'Cédula de ciudadanía (Parte Frontal)',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFF585858),
              ),
            ),
            SizedBox(height: 15),
            Container(
              width: 150,
              height: 90,
              color: Colors.grey[200],
              child: _frontalImageBase64 != null
                  ? Transform.rotate(
                      angle: 90 * 3.1415926535897932 / 180,
                      child: Image.memory(
                        base64Decode(_frontalImageBase64!),
                      ),
                    )
                  : Image.asset('assets/cedulaFrontal.png'),
            ),
            SizedBox(height: 5),
            ElevatedButton(
              onPressed: () async {
                final imagePath = await Navigator.push<String>(
                  context,
                  MaterialPageRoute(builder: (context) => Camera()),
                );
                if (imagePath != null) {
                  File rotatedImage = _rotateImage(File(imagePath));
                  await _convertAndSetFrontalImage(rotatedImage,
                      isFrontal: true);
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green[900],
                minimumSize: Size(145, 20),
              ),
              child: Text(
                'Añadir',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Cédula de ciudadanía (Parte Trasera)',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFF585858),
              ),
            ),
            SizedBox(height: 15),
            Container(
              width: 150,
              height: 90,
              color: Colors.grey[200],
              child: _traseraImageBase64 != null
                  ? Transform.rotate(
                      angle: 90 * 3.1415926535897932 / 180,
                      child: Image.memory(
                        base64Decode(_traseraImageBase64!),
                      ),
                    )
                  : Image.asset('assets/cedulaTrasera.png'),
            ),
            SizedBox(height: 5),
            ElevatedButton(
              onPressed: () async {
                final imagePath = await Navigator.push<String>(
                  context,
                  MaterialPageRoute(builder: (context) => Camera()),
                );
                if (imagePath != null) {
                  File rotatedImage = _rotateImage(File(imagePath));
                  await _convertAndSetFrontalImage(rotatedImage,
                      isFrontal: false);
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green[900],
                minimumSize: Size(145, 30),
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
                _numeroCedula = value;
                print('Número de cédula: $_numeroCedula');
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

  Widget _buildDateFormField(String labelText) {
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
          InkWell(
            onTap: () async {
              final DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (pickedDate != null && pickedDate != _selectedDate) {
                setState(() {
                  _selectedDate = pickedDate;
                  _fechaExpedicion = pickedDate;
                  print('Fecha de expedición: $_fechaExpedicion');
                });
              }
            },
            child: Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black54),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedDate != null
                        ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                        : '',
                  ),
                  Icon(Icons.calendar_today),
                ],
              ),
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
            var result = await _saveFormDocument();
            if (result == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegistroReciclador()),
              );
              //Navegar
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

  Future<int> _saveFormDocument() async {
    final recyclerModel = RecyclerModel.instance;
    print("entrando a guardar");
    try {
      recyclerModel.recycler.Document = _numeroCedula ?? '';
      recyclerModel.recycler.FotoDocumentoFrontal = _frontalImageBase64 ?? '';
      recyclerModel.recycler.FotoDocumentoTrasera = _traseraImageBase64 ?? '';
      recyclerModel.recycler.FechaExpedicion = _selectedDate;
      print('Fecha Expedicion selected: $_selectedDate');
      String frontalImageBase64 = _frontalImageBase64 ?? '';

      String traseraImageBase64 = _traseraImageBase64 ?? '';

      print('Número de cédula: $_numeroCedula');
      print('Fecha de expedición recycler: ${recyclerModel.recycler.FechaExpedicion}');
      print('Imagen frontal en base64: $frontalImageBase64');
      print('Imagen trasera en base64: $traseraImageBase64');
      return 1;
    } catch (e) {
      print(e);
      return 0;
    }
  }

  File _rotateImage(File imageFile) {
    final image = img.decodeImage(imageFile.readAsBytesSync())!;
    final rotatedImage = img.copyRotate(image, 90);
    return File(imageFile.path)..writeAsBytesSync(img.encodeJpg(rotatedImage));
  }

  Future<void> _convertAndSetFrontalImage(File imageFile,
      {required bool isFrontal}) async {
    try {
      List<int> imageBytes = await imageFile.readAsBytes();
      String base64Image = base64Encode(imageBytes);
      setState(() {
        if (isFrontal) {
          _frontalImageBase64 = base64Image;
        } else {
          _traseraImageBase64 = base64Image;
        }
      });
      print(isFrontal
          ? 'Imagen frontal en base64: $_frontalImageBase64'
          : 'Imagen trasera en base64: $_traseraImageBase64');
    } catch (e) {
      print('Error al convertir la imagen a base64: $e');
    }
  }
}
