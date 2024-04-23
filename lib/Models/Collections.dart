class Collections {
  int? id;
  String idUser;
  String idReciclador;
  String address;
  String description;
  String coordenadas;
  DateTime? hour;  
  DateTime? fechaRecoleccion;  

  // Constructor
  Collections({
    this.id,
    required this.idUser,
    required this.idReciclador,
    required this.address,
    required this.description,
    required this.coordenadas,
    this.hour,
    this.fechaRecoleccion,
  });

  Map<String, dynamic> toJson() {
    return {
      'IdUser': idUser,
      'IdReciclador': idReciclador,
      'Address': address,
      'Description': description,
      'Coordenadas': coordenadas,
      'Hour': hour?.toUtc().toIso8601String(), 
      'FechaRecoleccion': fechaRecoleccion?.toUtc().toIso8601String(), 
    };
  }
}
