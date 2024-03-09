import 'package:flutter/material.dart';

class RegistroUsuario extends StatelessWidget {
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
                  width: 280, height: 220,
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
                RegistroTextField(label: 'Nombres'),
                SizedBox(height: 10),
                RegistroTextField(label: 'Apellidos'),
                SizedBox(height: 10),
                RegistroTextField(label: 'Correo Electrónico'),
                SizedBox(height: 10),
                RegistroTextField(label: 'Contraseña'),
                SizedBox(height: 10),
                RegistroTextField(label: 'Confirmar Contraseña'),
                SizedBox(height: 20), 
                ElevatedButton(
                  onPressed: () {
                    // Lógica para crear cuenta
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF316C09), 
                    minimumSize: Size(250, 40), 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25), 
                      side: BorderSide(color: Color(0xFF316C09), width: 6), 
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
}

class RegistroTextField extends StatefulWidget {
  final String label;

  const RegistroTextField({Key? key, required this.label}) : super(key: key);

  @override
  _RegistroTextFieldState createState() => _RegistroTextFieldState();
}

class _RegistroTextFieldState extends State<RegistroTextField> {
  late TextEditingController _controller;
  bool _isLabelVisible = true;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 308,
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25), 
        border: Border.all(color: Color(0xFF316C09), width: 5), 
      ),
      child: TextField(
        controller: _controller,
        style: TextStyle(color: Color(0xFF585858)), 
        textAlignVertical: TextAlignVertical.top, 
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 15),
          hintText: _isLabelVisible ? widget.label : '',
          hintStyle: TextStyle(
            color: Color(0xFF585858),
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
}
