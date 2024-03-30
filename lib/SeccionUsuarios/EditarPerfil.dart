import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:visual1/Camara/Camara.dart';
import '../Widgets/BarraDeNavegacion.dart'; // Importa el widget de la barra de navegación
// Importa la clase DatabaseService
//import 'database_service.dart';

class EditarPerfil extends StatefulWidget {
  @override
  _EditarPerfilState createState() => _EditarPerfilState();
}

class _EditarPerfilState extends State<EditarPerfil> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  String _profileImagePath = 'assets/Perfil.png';
  DateTime? _selectedDate;
  String? _capturedImagePath;
  String _profileImageBase64 = '';
  File? _imageFile;
  bool _isEditing = false;

  // Instancia de DatabaseService
  //final DatabaseService _databaseService = DatabaseService();

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
    // Simulación de obtención de datos del perfil desde la base de datos
    _fetchProfileData();
  }

  // Método para simular la obtención de datos del perfil desde la base de datos
  void _fetchProfileData() {
    // Aquí puedes simular la obtención de datos del perfil
    // Por ejemplo, asignaremos datos estáticos para la demostración
    setState(() {
      _nameController.text = 'John Doe';
      _emailController.text = 'john.doe@example.com';
      _phoneController.text = '+1234567890';
      _addressController.text = '123 Main Street, City';
      _selectedDate = DateTime(1990, 1, 1); // Fecha de nacimiento simulada
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
        // Deshabilita la interacción del InkWell para bloquear la edición de la fecha
        AbsorbPointer(
          absorbing: true,
          child: InkWell(
            onTap: () {
              // No hacer nada cuando se hace clic en el campo de fecha
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
    // Captura los valores de los campos de texto
    String nombres = _nameController.text;
    String correoElectronico = _emailController.text;
    String telefono = _phoneController.text;
    String direccion = _addressController.text;

    // Guarda los datos en la base de datos
    /*_databaseService.saveProfileData(
      nombres: nombres,
      correoElectronico: correoElectronico,
      telefono: telefono,
      direccion: direccion,
    );
    */

    // Imprime los campos con los nuevos datos
    print('Nombres y Apellidos: $nombres');
    print('Correo Electrónico: $correoElectronico');
    print('Teléfono: $telefono');
    print('Dirección: $direccion');

    // Obtén los datos actualizados de la base de datos y actualiza la UI
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
