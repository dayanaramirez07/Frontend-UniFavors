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
    final estadoObj = json['estado'] as Map<String, dynamic>;

    return Producto(
      id: json['id'] as int?,
      estado: estadoObj['id'] as int,
      nombre: json['nombre'] as String,
      descripcion: json['descripcion'] as String,
      cantidad: json['cantidad'] as int,
      precio: json['precio'] as int,
      imagen: json['imagen'] as String,
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
