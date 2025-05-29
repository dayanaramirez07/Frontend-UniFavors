class Negocio {
  final int? id;
  final int categoria;
  final String nombre;
  final String representante;
  final String logo;

  Negocio({
    this.id,
    required this.categoria,
    required this.nombre,
    required this.representante,
    required this.logo,
  });

  factory Negocio.fromJson(Map<String, dynamic> json) {
    return Negocio(
      id: json['id'],
      categoria: json['categoria'],
      nombre: json['nombre'],
      representante: json['representante'],
      logo: json['logo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoria': categoria,
      'nombre': nombre,
      'representante': representante,
      'logo': logo,
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
