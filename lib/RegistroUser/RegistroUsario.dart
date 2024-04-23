import 'package:flutter/material.dart';
import '../Models/UsersModel.dart';
import 'RegistroCredencialesUser.dart'; 

class RegistroUsuario extends StatefulWidget {
  @override
  _RegistroUsuarioState createState() => _RegistroUsuarioState();
}

class _RegistroUsuarioState extends State<RegistroUsuario> {
  DateTime? _selectedDate;
  String? _nombresController;
  String? _apellidosController;
  String? _telefonoController;
  String? _addressController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 400,
            ),
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/registro.png',
                  width: 280,
                  height: 200,
                ),
                Text(
                  'Regístrate',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF265643),
                    fontFamily: 'RobotoMono',
                  ),
                ),
                SizedBox(height: 30),
                _buildTextField('Nombres', _nombresController),
                SizedBox(height: 10),
                _buildTextField('Apellidos', _apellidosController),
                SizedBox(height: 10),
                _buildTextField('Telefono', _telefonoController),
                SizedBox(height: 10),
                _buildTextField('Dirección', _addressController),
                SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: Container(
                    width: 308,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Color(0xFF316C09), width: 5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _selectedDate != null
                                ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                                : 'Fecha de Nacimiento',
                            style: TextStyle(
                              color: _selectedDate != null
                                  ? Color(0xFF585858)
                                  : Color(0xFF585858),
                              fontFamily: 'RobotoMono',
                            ),
                          ),
                          Icon(Icons.calendar_today),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    int result = await _saveFormDataUser();
                    if (result == 1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegistroCredencialesUser(),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF316C09),
                    minimumSize: Size(250, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                      side: BorderSide(
                        color: Color(0xFF316C09),
                        width: 6,
                      ),
                    ),
                  ),
                  child: Text(
                    'Siguiente',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String? controller,
      {bool isPassword = false}) {
    return Container(
      width: 308,
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Color(0xFF316C09), width: 5),
      ),
      child: TextField(
        onChanged: (value) {
          if (label == 'Nombres') {
            _nombresController = value;
          } else if (label == 'Apellidos') {
            _apellidosController = value;
          } else if (label == 'Telefono') {
            _telefonoController = value;
          } else if (label == 'Dirección') {
            _addressController = value;
          }
        },
        obscureText: isPassword,
        style: TextStyle(color: Color(0xFF585858), fontFamily: 'RobotoMono'),
        textAlignVertical: TextAlignVertical.top,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 15),
          hintText: label,
          hintStyle: TextStyle(
            color: Color(0xFF585858),
            fontFamily: 'RobotoMono',
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
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

  Future<int> _saveFormDataUser() async {
    final usersModel = UsersModel.instance;
    print("entrando a guardar");
    try {
      usersModel.users.Name = _nombresController ?? '';
      usersModel.users.LastName = _apellidosController ?? '';
      usersModel.users.Phone = _telefonoController ?? '';
      usersModel.users.Address = _addressController ?? '';
      usersModel.users.FechaNacimiento = _selectedDate;

      print('Nombres: $_nombresController');
      print('Apellidos: $_apellidosController');
      print('Teléfono: $_telefonoController');
      print('Dirección: $_addressController');
      print('Fecha de Nacimiento: $_selectedDate');

      return 1; // Operación exitosa
    } catch (e) {
      print(e);
      return 0; // Operación fallida
    }
  }
}
