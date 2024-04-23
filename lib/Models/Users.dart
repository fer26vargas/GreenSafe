class Users {
  int? id;
  String Name;
  String LastName;
  String Email;
  String Password;
  String Role;
  String Phone;
  String Address;
  DateTime? FechaNacimiento;
  String? Photo;


  // Constructor
  Users({
    this.id,
    required this.Name,
    required this.LastName,
    required this.Email,
    required this.Password,
    required this.Role,
    required this.Phone,
    required this.Address,
    this.FechaNacimiento,
    this.Photo,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': Name,
      'email': Email,
      'lastName': LastName,
      'password': Password,
      'role': Role,
      'phone': Phone,
      'address': Address,
      'fechaNacimiento': FechaNacimiento?.toUtc().toIso8601String(), 
      'Photo': Photo,
    };
  }
}