import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:visual1/Camara/Camara.dart';
import '../Widgets/BarraDeNavegacion.dart'; 

class EditarPerfil extends StatefulWidget {
  @override
  _EditarPerfilState createState() => _EditarPerfilState();
}

class _EditarPerfilState extends State<EditarPerfil> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  DateTime? _selectedDate;
  String _profileImageBase64 = '';
  File? _imageFile;
  bool _isEditing = false;

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
  void initState() {
    super.initState();
    _fetchProfileData();
  }

  void _fetchProfileData() {
    setState(() {
      _nameController.text = 'John Doe';
      _emailController.text = 'john.doe@example.com';
      _phoneController.text = '+1234567890';
      _addressController.text = '123 Main Street, City';
      _selectedDate = DateTime(1990, 1, 1); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                GestureDetector(
                  onTap: _isEditing ? _takePicture : null,
                  child: Container(
                    width: 100,
                    height: 100,
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
                        _isEditing
                            ? Positioned(
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
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                _buildFormField(
                  labelText: 'Nombres y Apellidos',
                  icon: Icons.person,
                  controller: _nameController,
                  enabled: _isEditing,
                ),
                SizedBox(height: 20),
                _buildFormField(
                  labelText: 'Correo Electrónico',
                  icon: Icons.email,
                  controller: _emailController,
                  enabled: _isEditing,
                ),
                SizedBox(height: 20),
                _buildFormField(
                  labelText: 'Teléfono',
                  icon: Icons.phone,
                  controller: _phoneController,
                  enabled: _isEditing,
                ),
                SizedBox(height: 20),
                _buildFormField(
                  labelText: 'Dirección',
                  icon: Icons.location_on,
                  controller: _addressController,
                  enabled: _isEditing,
                ),
                SizedBox(height: 20),
                _buildDateOfBirthField(),
                SizedBox(height: 20),
                _buildEditButton(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BarraDeNavegacion(),
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
        AbsorbPointer(
          absorbing: true,
          child: InkWell(
            onTap: () {
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
        ),
      ],
    );
  }

  Widget _buildFormField({
    required String labelText,
    required IconData icon,
    TextEditingController? controller,
    bool enabled = true,
  }) {
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
          enabled: enabled,
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

  Widget _buildEditButton() {
    return ElevatedButton.icon(
      onPressed: () {
        // Si estamos editando, guarda los datos
        if (_isEditing) {
          _saveFormData();
        }
        // Cambia el estado de _isEditing
        setState(() {
          _isEditing = !_isEditing;
        });
      },
      icon: Icon(_isEditing ? Icons.save : Icons.edit),
      label: Text(_isEditing ? 'Guardar' : 'Editar'),
    );
  }

  void _saveFormData() {
    String nombres = _nameController.text;
    String correoElectronico = _emailController.text;
    String telefono = _phoneController.text;
    String direccion = _addressController.text;
    print('Nombres y Apellidos: $nombres');
    print('Correo Electrónico: $correoElectronico');
    print('Teléfono: $telefono');
    print('Dirección: $direccion');

    _fetchProfileData();
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
}
