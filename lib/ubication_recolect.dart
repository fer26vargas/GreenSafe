import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UbicaRecoleccion extends StatefulWidget {
  @override
  _UbicaRecoleccionState createState() => _UbicaRecoleccionState();
}

class _UbicaRecoleccionState extends State<UbicaRecoleccion> {
  late GoogleMapController mapController;
  final LatLng _initialPosition = const LatLng(45.521563, -122.677433); // Initial map position
  double? latitude; // Variable to store latitude
  double? longitude; // Variable to store longitude

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ubicación de los puntos de recolección'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _initialPosition,
                zoom: 11.0,
              ),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            onChanged: (value) {
              latitude = double.tryParse(value);
            },
            decoration: InputDecoration(
              labelText: 'Latitud',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            onChanged: (value) {
              longitude = double.tryParse(value);
            },
            decoration: InputDecoration(
              labelText: 'Longitud',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Save changes logic
              if (latitude != null && longitude != null) {
                // Use latitude and longitude values
                print('Latitude: $latitude, Longitude: $longitude');
              } else {
                print('Please enter valid latitude and longitude.');
              }
            },
            child: Text('Guardar Cambios'),
          ),
        ],
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
}
