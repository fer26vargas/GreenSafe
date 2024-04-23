import 'package:visual1/Models/Users.dart';

class UsersModel {
  Users users = Users( 
    Name: '',
    LastName : '',
    Email: '',
    Password: '',
    Role: 'Usuario',
    Phone: '',
    Address: '',
    FechaNacimiento: DateTime.now(),
    Photo: '',
  );

  UsersModel._internal();

  static final UsersModel instance = UsersModel._internal();
}
