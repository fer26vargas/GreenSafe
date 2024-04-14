import 'package:flutter/material.dart';

class RegistroUsuario extends StatefulWidget {
  @override
  _RegistroUsuarioState createState() => _RegistroUsuarioState();
}

class _RegistroUsuarioState extends State<RegistroUsuario> {
  late TextEditingController _nombresController;
  late TextEditingController _apellidosController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  DateTime? _selectedDate;
  late bool _isLabelVisible;

  @override
  void initState() {
    super.initState();
    _nombresController = TextEditingController();
    _apellidosController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _isLabelVisible = true;
  }

  @override
  void dispose() {
    _nombresController.dispose();
    _apellidosController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _saveFormData() {
    String nombres = _nombresController.text;
    String apellidos = _apellidosController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;
    String fechaNacimiento = _selectedDate != null
        ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
        : '';

  }

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
                _buildTextField('Correo Electrónico', _emailController),
                SizedBox(height: 10),
                _buildTextField('Contraseña', _passwordController, isPassword: true),
                SizedBox(height: 10),
                _buildTextField('Confirmar Contraseña', _confirmPasswordController, isPassword: true),
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
                  onPressed: _saveFormData,
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
                    'Crear cuenta',
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

  Widget _buildTextField(String label, TextEditingController controller, {bool isPassword = false}) {
    return Container(
      width: 308,
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Color(0xFF316C09), width: 5),
      ),
      child: TextField(
        controller: controller,
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
        onChanged: (value) {
          setState(() {
            _isLabelVisible = value.isEmpty;
          });
        },
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
}
