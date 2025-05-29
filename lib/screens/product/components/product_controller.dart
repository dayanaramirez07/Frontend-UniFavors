import 'package:flutter/material.dart';
import 'package:uni_favors/services/producto_service.dart';
import 'package:uni_favors/models/producto.dart';

class ProductController {
  final ProductoService productoService = ProductoService();

  Future<void> handleCrearProducto({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required TextEditingController nombreController,
    required TextEditingController descripcionController,
    required TextEditingController cantidadController,
    required TextEditingController precioController,
    required TextEditingController imagenController,
    required String? estadoSeleccionado,
  }) async {
    formKey.currentState!.save();
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    final producto = Producto(
      nombre: nombreController.text.trim(),
      descripcion: descripcionController.text.trim(),
      cantidad: int.parse(cantidadController.text.trim()),
      precio: int.parse(precioController.text.trim()),
      imagen: imagenController.text.trim(),
      estado: Producto.obtenerEstado(estadoSeleccionado),
    );

    await productoService.crearProducto(producto);

    if (!context.mounted) return;
  }
}
