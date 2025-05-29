class Producto {
  final int? id;
  final int estado;
  final String nombre;
  final String descripcion;
  final int cantidad;
  final int precio;
  final String imagen;

  Producto({
    this.id,
    required this.estado,
    required this.nombre,
    required this.descripcion,
    required this.cantidad,
    required this.precio,
    required this.imagen,
  });

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      id: json['id'],
      estado: json['estado'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      cantidad: json['cantidad'],
      precio: json['precio'],
      imagen: (json['imagen'] as String?) ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'estado': estado,
      'nombre': nombre,
      'descripcion': descripcion,
      'cantidad': cantidad,
      'precio': precio,
      'imagen': imagen,
    };
  }

  String get nombreEstado {
    switch (estado) {
      case 1:
        return 'Disponible';
      case 2:
        return 'Bajo Demanda';
      case 3:
        return 'Agotado';
      default:
        return '';
    }
  }

  static int obtenerEstado(String? estado) {
    switch (estado) {
      case 'Disponible':
        return 1;
      case 'Bajo Demanda':
        return 2;
      case 'Agotado':
        return 3;
      default:
        return 0;
    }
  }
}
