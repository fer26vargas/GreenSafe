import 'package:visual1/Models/Recycler.dart';

class RecyclerModel {
  Recycler recycler = Recycler( 
    Name: '',
    Email: '',
    Password: '',
    Role: 'Reciclador',
    Document: '',
    Phone: '',
    Address: '',
    FechaNacimiento: DateTime.now(),
    Bascula: '',
    Placa: '',
    DescripcionVehiculo: '',
    FotoVehiculo: '',
    Photo: '',
    FotoDocumentoFrontal: '',
    FotoDocumentoTrasera: '',
    FechaExpedicion: DateTime.now(),
  );

  RecyclerModel._internal();

  static final RecyclerModel instance = RecyclerModel._internal();
}
