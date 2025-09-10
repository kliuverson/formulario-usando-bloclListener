class UserModel {
  final String nombre;
  final String apellido;
  final String correo;
  final String password;

  UserModel({
    required this.nombre,
    required this.apellido,
    required this.correo,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "nombre": nombre,
      "apellido": apellido,
      "correo": correo,
      "password": password,
    };
  }
}
