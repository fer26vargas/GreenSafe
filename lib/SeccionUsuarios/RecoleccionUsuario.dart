import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
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
  TextEditingController _descriptionController = TextEditingController();

  // Lista de días disponibles
  List<DateTime> _diasDisponibles = [
    DateTime.now().subtract(Duration(days: 1)),
    DateTime.now(),
    DateTime.now().add(Duration(days: 1)),
  ];

  // Variables para ubicación
  DateTime? _selectedAvailableDate;
  double? _latitude;
  double? _longitude;
  bool _isLoadingLocation = false;

  // Método para solicitar permiso de ubicación
  void _requestLocationPermission() async {
    final PermissionStatus status = await Permission.location.request();
    if (status.isGranted) {
      _getLocation();
    } else if (status.isDenied) {
      // Permiso denegado, puedes manejar esto aquí
    } else if (status.isPermanentlyDenied) {
      // Permiso denegado permanentemente, puedes mostrar un diálogo para que el usuario lo habilite en la configuración de la aplicación
    }
  }

  // Método para obtener la ubicación actual
  Future<void> _getLocation() async {
    try {
      setState(() {
        _isLoadingLocation = true;
      });

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _latitude = position.latitude;
        _longitude = position.longitude;
      });

      // Actualiza la ubicación desde las coordenadas
      _updateLocationFromCoordinates(position.latitude, position.longitude);
    } catch (e) {
      print('Error obteniendo la ubicación: $e');
    } finally {
      setState(() {
        _isLoadingLocation = false; // Ocultar indicador de carga
      });
    }
  }

  // Método para actualizar la ubicación desde las coordenadas
  Future<void> _updateLocationFromCoordinates(
      double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);

      setState(() {
        _locationController.text = placemarks.first.street ?? '';
        _latitude = latitude;
        _longitude = longitude;
      });
    } catch (e) {
      print('Error obteniendo la dirección: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

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
                'Programa tu próxima recolección',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[900],
                ),
              ),
            ),
            _buildCalendar(),
            SizedBox(height: 5),
            _buildLocationEditor(),
            SizedBox(height: 5),
            _buildDescriptionEditor(),
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
      calendarStyle: const CalendarStyle(
        cellMargin: EdgeInsets.zero,
        defaultTextStyle: TextStyle(fontSize: 10),
      ),
      daysOfWeekStyle: const DaysOfWeekStyle(
        weekdayStyle: TextStyle(fontSize: 10),
        weekendStyle: TextStyle(fontSize: 10),
      ),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDate = selectedDay;
          _selectedAvailableDate = selectedDay;
        });
      },
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, date, events) {
          bool isAvailable = date.weekday == DateTime.tuesday ||
              date.weekday == DateTime.thursday;
          return isAvailable ? _buildAvailableDayMarker(date) : SizedBox();
        },
        selectedBuilder: (context, date, focusedDay) {
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

  Future<void> _getCurrentLocation() async {
    try {
      final bool isLocationServiceEnabled =
          await Geolocator.isLocationServiceEnabled();
      if (!isLocationServiceEnabled) {
        return;
      }

      final PermissionStatus status = await Permission.locationWhenInUse.status;
      if (status.isGranted) {
        _getLocation();
      } else {
        _requestLocationPermission();
      }
    } catch (e) {
      print('Error obteniendo la ubicación: $e');
    }
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
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _locationController,
                  readOnly: false,
                  decoration: InputDecoration(
                    hintText:
                        'Presione el icono para tomar su direccion exacta',
                    suffixIcon: IconButton(
                      icon: _isLoadingLocation
                          ? CircularProgressIndicator()
                          : Icon(Icons.location_on),
                      onPressed: () {
                        _getCurrentLocation();
                      },
                    ),
                  ),
                  onChanged: (value) {
                    _updateLocationFromAddress(value);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _updateLocationFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        setState(() {
          _latitude = locations.first.latitude;
          _longitude = locations.first.longitude;
        });
      }
    } catch (e) {
      print('Error obteniendo la ubicación desde la dirección: $e');
    }
  }

  Widget _buildDescriptionEditor() {
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
            'Descripción',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green[900]),
          ),
          SizedBox(height: 10),
          TextField(
            controller: _descriptionController,
            decoration: InputDecoration(
              hintText: 'Casa, Apto, Universidad, Tienda ...',
            ),
            onChanged: (value) {
              print('Descripción: $value');
            },
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

  void _confirmRecoleccion(
      DateTime selectedDate,
      TimeOfDay selectedTime,
      String location,
      double latitude,
      double longitude,
      String description) {
    if (selectedDate == null ||
        selectedTime == null ||
        location.isEmpty ||
        latitude == null ||
        longitude == null ||
        description.isEmpty) {
      // Si falta alguno de los campos, muestra un mensaje de error
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Por favor complete todos los campos.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Aceptar'),
              ),
            ],
          );
        },
      );
    } else {
      // Si todos los campos están completos, muestra la confirmación
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirmar Recolección'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Fecha: $selectedDate'),
                Text('Hora: ${selectedTime.hour}:${selectedTime.minute}'),
                Text('Ubicación: $location'),
                Text('Descripción: $description'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Aceptar'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancelar'),
              ),
            ],
          );
        },
      );
    }
  }

  Widget _buildConfirmButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        onPressed: () {
          _confirmRecoleccion(
            _selectedDate,
            _selectedTime,
            _locationController.text,
            _latitude ?? 0.0,
            _longitude ?? 0.0,
            _descriptionController.text,
          );
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
