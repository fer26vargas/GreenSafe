import 'package:visual1/Models/Collections.dart';

class CollectionsModel {
  Collections collections = Collections( 
    idUser: '',
    idReciclador: '5',
    address: '',
    description: '',
    coordenadas: '',
    fechaRecoleccion: DateTime.now(),
    hour: DateTime.now(),

  );

  CollectionsModel._internal();

  static final CollectionsModel instance = CollectionsModel._internal();
}
