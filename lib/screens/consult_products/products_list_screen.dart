import 'package:flutter/material.dart';
import 'package:uni_favors/constants.dart';
import 'package:uni_favors/components/custom_card.dart';
import 'package:uni_favors/models/producto.dart';
import 'package:uni_favors/services/producto_service.dart';

class ProductsListScreen extends StatefulWidget {
  final int negocioId;
  const ProductsListScreen({super.key, required this.negocioId});

  @override
  State<ProductsListScreen> createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {
  final ProductoService _productoService = ProductoService();
  late Future<List<Producto>> _productosFuture;

  @override
  void initState() {
    super.initState();
    _productosFuture = _productoService.consultarProductoPorNegocio(
      widget.negocioId,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Center(
      child: SizedBox(
        height: size.height,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20),
                Text(
                  'Productos',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: kPrimaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                FutureBuilder<List<Producto>>(
                  future: _productosFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    final productos = snapshot.data!;
                    if (productos.isEmpty) {
                      return const Center(child: Text('No hay productos'));
                    }
                    return Column(
                      children:
                          productos.map((producto) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: CustomCard(
                                title: Text(
                                  producto.nombre,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(producto.descripcion),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Estado: ${producto.nombreEstado}'),
                                    Text('Cantidad: ${producto.cantidad}'),
                                    Text('Precio: ${producto.precio}'),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      'Contactar vendedor',
                                      style: TextStyle(color: kPrimaryColor),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
