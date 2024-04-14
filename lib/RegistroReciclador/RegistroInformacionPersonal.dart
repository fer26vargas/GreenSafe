import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:visual1/Camara/Camara.dart';

import '../Models/RecyclerModel.dart';
import 'RegistroReciclador.dart';

class RegistroInformacionPersonal extends StatefulWidget {
  @override
  _RegistroInformacionPersonalState createState() =>
      _RegistroInformacionPersonalState();
}

class _RegistroInformacionPersonalState
    extends State<RegistroInformacionPersonal> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  DateTime? _selectedDate;
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
      appBar: AppBar(
        title: Text('Información Personal'),
        backgroundColor: Colors.green[900],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                                backgroundImage:
                                    AssetImage('assets/Perfil.png'),
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
                SizedBox(height: 20),
                _buildFormField(
                  labelText: 'Nombres y Apellidos',
                  icon: Icons.person,
                  controller: _nameController,
                ),
                SizedBox(height: 20),
                _buildFormField(
                  labelText: 'Direccion',
                  icon: Icons.house,
                  controller: _addressController,
                ),
                SizedBox(height: 20),
                _buildFormField(
                  labelText: 'Teléfono',
                  icon: Icons.phone,
                  controller: _phoneController,
                ),
                SizedBox(height: 20),
                _buildDateOfBirthField(),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(20),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              _saveFormData();
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

  Widget _buildDateOfBirthField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Fecha de Nacimiento',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5),
        InkWell(
          onTap: () {
            _showDatePicker();
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
                  style: TextStyle(color: Colors.black),
                ),
                Icon(Icons.calendar_today),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _showDatePicker() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Widget _buildFormField(
      {required String labelText,
      required IconData icon,
      TextEditingController? controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.black54,
              size: 20,
            ),
            SizedBox(width: 10),
            Text(
              labelText,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
          ),
          controller: controller,
          onChanged: (value) {},
        ),
      ],
    );
  }

  Future<int> _saveFormData() async {
    final recyclerModel = RecyclerModel.instance;
    print("entrando a guardar");
    try {
      String nombres = _nameController.text;

      recyclerModel.recycler.Name = nombres;
      recyclerModel.recycler.Address = _addressController.text;
      recyclerModel.recycler.Phone = _phoneController.text;
      recyclerModel.recycler.FechaNacimiento = _selectedDate;
      recyclerModel.recycler.Photo = _profileImageBase64;

      print(
          'El nombre recyclador desde save es: ${recyclerModel.recycler.Name}');
      print('fecha nacimiento: ${recyclerModel.recycler.FechaNacimiento}');

      String direccion = _addressController.text;
      String telefono = _phoneController.text;
      String fotoDePerfil = _profileImageBase64;
      print('imagen: $direccion');
      print('imagen: $telefono');
      print('imagen: $fotoDePerfil');
      return 1;
    } catch (e) {
      print(e);
      return 0;
    }
  }
}
