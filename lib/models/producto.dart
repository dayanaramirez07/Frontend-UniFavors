class Producto {
  final int id;
  final int estado;
  final String nombreProducto;
  final String descripcion;
  final int cantidad;
  final double precio;
  final String imagen;

  Producto({
    required this.id,
    required this.estado,
    required this.nombreProducto,
    required this.descripcion,
    required this.cantidad,
    required this.precio,
    required this.imagen,
  });

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      id: json['id'],
      estado: json['estado'],
      nombreProducto: json['nombreProducto'],
      descripcion: json['descripcion'],
      cantidad: json['cantidad'],
      precio: json['precio'],
      imagen: json['imagen'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'estado': estado,
      'nombreProducto': nombreProducto,
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
}
