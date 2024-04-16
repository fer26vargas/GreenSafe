import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * .6,
          child: GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(target: _center, zoom:11),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child:
              TextField(decoration: InputDecoration(labelText:'Latitud')),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child:
              TextField(decoration: InputDecoration(labelText:'Longitud')),
        ),
        ElevatedButton(onPressed: () {}, child: Text('Guardar Cambios'))
      ],
    );
  }
}
