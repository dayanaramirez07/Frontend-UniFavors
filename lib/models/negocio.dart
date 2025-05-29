class Negocio {
  final int? id;
  final int categoria;
  final String nombre;
  final String representante;
  final String logo;
  final int usuarioId;
  final String? contacto;

  Negocio({
    this.id,
    required this.categoria,
    required this.nombre,
    required this.representante,
    required this.logo,
    required this.usuarioId,
    this.contacto,
  });

  factory Negocio.fromJson(Map<String, dynamic> json) {
    final negocioJson = json['negocio'] as Map<String, dynamic>;
    final categoriaJson = negocioJson['categoria'] as Map<String, dynamic>;

    return Negocio(
      id: negocioJson['id'] as int?,
      categoria: categoriaJson['categoriaID'] as int,
      nombre: negocioJson['nombre'] as String,
      representante: negocioJson['representanteNombre'] as String,
      logo: negocioJson['logo'] as String,
      usuarioId: json['id'] as int,
      contacto: json['celular'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categoria': categoria,
      'nombre': nombre,
      'representante': representante,
      'logo': logo,
      'usuario': {'id': usuarioId},
    };
  }

  String get nombreCategoria {
    switch (categoria) {
      case 1:
        return 'Belleza';
      case 2:
        return 'Libros';
      case 3:
        return 'Postres';
      default:
        return 'Otra';
    }
  }

  static int obtenerCategoria(String? categoria) {
    switch (categoria) {
      case 'Belleza':
        return 1;
      case 'Libros':
        return 2;
      case 'Postres':
        return 3;
      default:
        return 0;
    }
  }
}
