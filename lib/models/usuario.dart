class Usuario {
  final int? id;
  final int tipoUsuario;
  final String nombreUsuario;
  final String correo;
  final String celular;
  final String? contrasenna;
  final String? passwordHash;

  Usuario({
    this.id,
    required this.tipoUsuario,
    required this.nombreUsuario,
    required this.correo,
    required this.celular,
    this.contrasenna,
    this.passwordHash,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      tipoUsuario: json['tipoUsuario'],
      nombreUsuario: json['nombreUsuario'],
      correo: json['correo'],
      celular: json['celular'],
      contrasenna: json['contraseña'],
      passwordHash: json['passwordHash'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = {
      'tipoUsuario': tipoUsuario,
      'nombreUsuario': nombreUsuario,
      'correo': correo,
      'celular': celular,
      'contraseña': contrasenna,
    };

    if (id != null) {
      data['id'] = id;
    }

    return data;
  }

  String get tipoNombre {
    switch (tipoUsuario) {
      case 1:
        return 'Admin';
      case 2:
        return 'Cliente';
      case 3:
        return 'Vendedor';
      case 4:
        return 'Compa';
      default:
        return '';
    }
  }

  static int obtenerTipoUsuario(String? tipo) {
    switch (tipo) {
      case 'Cliente':
        return 2;
      case 'Vendedor':
        return 3;
      case 'Compa':
        return 4;
      default:
        return 0;
    }
  }
}
