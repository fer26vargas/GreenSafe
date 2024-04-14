class Recycler {
  int? id;
  String Name;
  String Email;
  String Password;
  String Role;
  String Document;
  String Phone;
  String Address;
  DateTime? FechaNacimiento;
  String? Bascula;
  String? Placa;
  String? DescripcionVehiculo;
  String? FotoVehiculo;
  String? Photo;
  String? FotoDocumentoFrontal;
  String? FotoDocumentoTrasera;
  DateTime? FechaExpedicion;


  // Constructor
  Recycler({
    this.id,
    required this.Name,
    required this.Email,
    required this.Password,
    required this.Role,
    required this.Document,
    required this.Phone,
    required this.Address,
    this.FechaNacimiento,
    this.Bascula,
    this.Placa,
    this.DescripcionVehiculo,
    this.FotoVehiculo,
    this.Photo,
    this.FotoDocumentoFrontal,
    this.FotoDocumentoTrasera,
    this.FechaExpedicion,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': Name,
      'email': Email,
      'password': Password,
      'role': Role,
      'document': Document,
      'phone': Phone,
      'address': Address,
      'fechaNacimiento': FechaNacimiento?.toUtc().toIso8601String(), 
      'bascula': Bascula,
      'placa': Placa,
      'DescripcionVehiculo': DescripcionVehiculo,
      'FotoVehiculo': FotoVehiculo,
      'Photo': Photo,
      'FotoDocumentoFrontal': FotoDocumentoFrontal,
      'FotoDocumentoTrasera': FotoDocumentoTrasera,
      'FechaExpedicion': FechaExpedicion?.toUtc().toIso8601String(), 
      
    };
  }
}