import 'package:flutter/material.dart';
import '../Camara/Camara.dart'; // Asegúrate de importar el archivo de la nueva vista de la cámara

class RegistroInformacionPersonal extends StatefulWidget {
  @override
  _RegistroInformacionPersonalState createState() =>
      _RegistroInformacionPersonalState();
}

class _RegistroInformacionPersonalState
    extends State<RegistroInformacionPersonal> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String _profileImagePath = 'assets/Perfil.png';
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: Text('Información Personal'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    final imagePath = await Navigator.push<String>(
                      context,
                      MaterialPageRoute(builder: (context) => Camera()),
                    );
                    if (imagePath != null) {
                      setState(() {
                        _profileImagePath = imagePath;
                      });
                    }
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(0xFF1B5E20), width: 2),
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage(_profileImagePath),
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
                  labelText: 'Correo Electrónico',
                  icon: Icons.email,
                  controller: _emailController,
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
              _saveFormData(); // Captura los datos del formulario cuando se presiona el botón de guardar
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
                      : 'Seleccione la fecha',
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
        _selectedDate =
            pickedDate; // Captura la fecha de nacimiento seleccionada por el usuario
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
          controller: controller, // Asigna el controlador al campo de texto
          onChanged: (value) {
            // Captura el valor del campo de texto cuando cambia
            // Puedes almacenar estos valores en variables o en algún objeto según sea necesario
            // Por ejemplo, puedes usar un Map<String, dynamic> o un modelo de datos personalizado
          },
        ),
      ],
    );
  }

  void _saveFormData() {
    // Capturar el valor del campo de nombres y apellidos
    // Puedes acceder al valor utilizando un controlador o mediante el método onChanged
    // Por ejemplo, si estás utilizando onChanged, podrías tener una variable de estado para cada campo y capturar el valor de esta manera:
    String nombres = _nameController.text;

    // Capturar el valor del campo de correo electrónico
    // Aquí también puedes acceder al valor utilizando un controlador o mediante el método onChanged
    // Por ejemplo, si estás utilizando onChanged, podrías tener una variable de estado para el correo electrónico y capturar el valor de esta manera:
    String correoElectronico = _emailController.text;

    // Capturar el valor del campo de teléfono
    // De manera similar, puedes acceder al valor utilizando un controlador o mediante el método onChanged
    // Por ejemplo, si estás utilizando onChanged, podrías tener una variable de estado para el teléfono y capturar el valor de esta manera:
    String telefono = _phoneController.text;
  
    // Ahora puedes hacer lo que necesites con los datos capturados, como enviarlos a una base de datos, guardarlos localmente, etc.
  }
}
