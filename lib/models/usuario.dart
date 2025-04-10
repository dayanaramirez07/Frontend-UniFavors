class Usuario {
  final int id;
  final int tipo;
  final String nombre;
  final String correo;
  final String celular;
  final String contrasena;

  Usuario({
    required this.id,
    required this.tipo,
    required this.nombre,
    required this.correo,
    required this.celular,
    required this.contrasena,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      tipo: json['tipo'],
      nombre: json['nombre'],
      correo: json['correo'],
      celular: json['celular'],
      contrasena: json['contrasena'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tipo': tipo, 
      'nombre': nombre,
      'correo': correo,
      'celular': celular,
      'contrasena': contrasena,
    };
  }
}