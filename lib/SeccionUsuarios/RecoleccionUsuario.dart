import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../Widgets/Menu.dart';
import '../Widgets/BarraDeNavegacion.dart';

class RecoleccionUsuario extends StatefulWidget {
  @override
  _RecoleccionUsuarioState createState() => _RecoleccionUsuarioState();
}

class _RecoleccionUsuarioState extends State<RecoleccionUsuario> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  TextEditingController _locationController = TextEditingController();

  List<DateTime> _diasDisponibles = [
    DateTime.now().subtract(Duration(days: 1)), // Ejemplo: Ayer
    DateTime.now(), // Ejemplo: Hoy
    DateTime.now().add(Duration(days: 1)), // Ejemplo: Mañana
    // Agrega aquí otros días disponibles según tu lógica
  ];

  DateTime?
      _selectedAvailableDate; // Variable para almacenar la fecha seleccionada disponible

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 40), // Espacio para el menú
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.menu,
                    size: 32,
                    color: Colors.black87,
                  ),
                  onPressed: () {
                    // Mostrar el menú
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Menu();
                      },
                    );
                  },
                ),
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Programa tu próxima \nrecolección',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[900],
                ),
              ),
            ),
            _buildCalendar(),
            SizedBox(height: 5),
            _buildLocationEditor(),
            SizedBox(height: 5),
            _buildTimePicker(),
            SizedBox(height: 10),
            _buildConfirmButton(),
          ],
        ),
      ),
      bottomNavigationBar: BarraDeNavegacion(),
    );
  }

  Widget _buildCalendar() {
    return TableCalendar(
      focusedDay: _selectedDate,
      firstDay: DateTime.now(),
      lastDay: DateTime.now().add(Duration(days: 365)),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDate = selectedDay;
          // Variable que almacena la fecha seleccionada
          _selectedAvailableDate = selectedDay;
          print(
              'Fecha seleccionada: $_selectedAvailableDate'); // Print de la fecha seleccionada
        });
      },
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, date, events) {
          // Verificar si el día está disponible (martes o jueves)
          bool isAvailable = date.weekday == DateTime.tuesday ||
              date.weekday == DateTime.thursday;
          return isAvailable ? _buildAvailableDayMarker(date) : SizedBox();
        },
        selectedBuilder: (context, date, focusedDay) {
          // Verificar si el día seleccionado es el día disponible
          bool isSelectedAvailable = _selectedAvailableDate != null &&
              isSameDay(date, _selectedAvailableDate!);
          return isSelectedAvailable
              ? _buildSelectedAvailableDayMarker(date)
              : SizedBox();
        },
      ),
    );
  }

  Widget _buildAvailableDayMarker(DateTime date) {
    bool isSelected = _selectedAvailableDate != null &&
        isSameDay(date, _selectedAvailableDate!);
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.green[900]!, width: 2),
        color: isSelected ? Colors.green[900] : Colors.white,
      ),
      child: Center(
        child: Text(
          '${date.day}',
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.green[900],
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedAvailableDayMarker(DateTime date) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.green[900],
      ),
      child: Center(
        child: Text(
          '${date.day}',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildLocationEditor() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.green[900]!, width: 2),
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ubicación de Recolección',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green[900]),
          ),
        ],
      ),
    );
  }

  Widget _buildTimePicker() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.green[900]!, width: 2),
      ),
      child: ListTile(
        title: Text(
          'Hora de Recolección',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.green[900]),
        ),
        trailing: TextButton(
          onPressed: () => _selectTime(context),
          child: Text(
            '${_selectedTime.hour}:${_selectedTime.minute}',
            style: TextStyle(fontSize: 16, color: Colors.green[900]),
          ),
        ),
      ),
    );
  }

  Widget _buildConfirmButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        onPressed: () {
          // Implementar lógica para confirmar la programación de la recolección
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.green[900],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Text(
            'Confirmar Recolección',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }
}
