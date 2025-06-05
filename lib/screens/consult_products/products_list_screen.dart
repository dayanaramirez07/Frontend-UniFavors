import 'package:flutter/material.dart';
import 'package:uni_favors/constants.dart';
import 'package:uni_favors/components/custom_card.dart';
import 'package:uni_favors/models/producto.dart';
import 'package:uni_favors/services/producto_service.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductsListScreen extends StatefulWidget {
  final int negocioId;
  final String contacto;
  const ProductsListScreen({
    super.key,
    required this.negocioId,
    required this.contacto,
  });

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
                                    onPressed: () {
                                      if (producto.estado == 2) {
                                        final url =
                                            'https://wa.me/${573128567530}?text=Hola, estoy interesado en el producto "${producto.nombre}"';
                                        launchUrl(Uri.parse(url));
                                      } else {
                                        int cantidad = 1;
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return StatefulBuilder(
                                              builder: (context, setState) {
                                                double total =
                                                    cantidad.toDouble() *
                                                    producto.precio;
                                                return AlertDialog(
                                                  title: Center(
                                                    child: Text(
                                                      producto.nombre,
                                                    ),
                                                  ),
                                                  content: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Center(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            const Text(
                                                              'Cantidad: ',
                                                            ),
                                                            const SizedBox(
                                                              width: 8,
                                                            ),
                                                            DropdownButton<int>(
                                                              value: cantidad,
                                                              items:
                                                                  List.generate(
                                                                        producto
                                                                            .cantidad,
                                                                        (i) =>
                                                                            i +
                                                                            1,
                                                                      )
                                                                      .map(
                                                                        (
                                                                          e,
                                                                        ) => DropdownMenuItem<
                                                                          int
                                                                        >(
                                                                          value:
                                                                              e,
                                                                          child: Text(
                                                                            e.toString(),
                                                                          ),
                                                                        ),
                                                                      )
                                                                      .toList(),
                                                              onChanged: (
                                                                value,
                                                              ) {
                                                                if (value !=
                                                                    null) {
                                                                  setState(() {
                                                                    cantidad =
                                                                        value;
                                                                  });
                                                                }
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        'Precio total: \$${total.toStringAsFixed(0)}',
                                                      ),
                                                    ],
                                                  ),
                                                  actionsAlignment:
                                                      MainAxisAlignment.center,
                                                  actions: [
                                                    TextButton(
                                                      onPressed:
                                                          () => Navigator.pop(
                                                            context,
                                                          ),
                                                      child: const Text(
                                                        'Cancelar',
                                                      ),
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        ScaffoldMessenger.of(
                                                          context,
                                                        ).showSnackBar(
                                                          const SnackBar(
                                                            content: Text(
                                                              'Compra realizada.',
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: const Text(
                                                        'Comprar',
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                        );
                                      }
                                    },
                                    child: Text(
                                      producto.estado == 1
                                          ? 'Realizar pedido'
                                          : 'Contactar vendedor',
                                      style: const TextStyle(
                                        color: kPrimaryColor,
                                      ),
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
