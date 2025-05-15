import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uni_favors/constants.dart';
import 'package:uni_favors/models/producto.dart';

class ProductoService {
  final String urlProducto = '${environment}api/productos';

  Future<List<Producto>> consultarProductos() async {
    final response = await http.get(Uri.parse(urlProducto));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((producto) => Producto.fromJson(producto)).toList();
    } else {
      throw Exception('Error al cargar los productos');
    }
  }

  Future<Producto> consultarProductoPorId(int id) async {
    final response = await http.get(Uri.parse('$urlProducto/$id'));

    if (response.statusCode == 200) {
      return Producto.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al cargar el producto');
    }
  }

  Future<void> crearProducto(Producto producto) async {
    final response = await http.post(
      Uri.parse(urlProducto),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(producto.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Error al crear el producto');
    }
  }

  Future<void> actualizarProducto({
    required int id,
    String? nuevaImagen,
    int? nuevaCantidad,
    String? nuevoEstado,
    double? nuevoPrecio,
  }) async {
    final body = <String, String>{};

    if (nuevaImagen != null) body['nuevaImagen'] = nuevaImagen;
    if (nuevaCantidad != null) body['nuevaCantidad'] = nuevaCantidad.toString();
    if (nuevoEstado != null) body['nuevoEstado'] = nuevoEstado;
    if (nuevoPrecio != null) body['nuevoPrecio'] = nuevoPrecio.toString();

    final response = await http.patch(
      Uri.parse('$urlProducto/$id'),
      headers: <String, String>{
        'Authorization': 'Basic ${base64Encode(utf8.encode('user:password'))}',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: body,
    );

    if (response.statusCode != 200) {
      throw Exception('Error al actualizar el producto');
    }
  }

  Future<void> eliminarProducto(int id) async {
    final response = await http.delete(
      Uri.parse('$urlProducto/$id'),
      headers: <String, String>{
        'Authorization': 'Basic ${base64Encode(utf8.encode('user:password'))}',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar el producto');
    }
  }
}
