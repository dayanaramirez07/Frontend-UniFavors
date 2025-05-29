import 'package:flutter/material.dart';
import 'package:uni_favors/constants.dart';
import 'package:uni_favors/models/producto.dart';
import 'package:uni_favors/services/producto_service.dart';

class ConsultProductsScreen extends StatefulWidget {
  const ConsultProductsScreen({super.key});

  @override
  State<ConsultProductsScreen> createState() => _ConsultUsersScreenState();
}

class _ConsultUsersScreenState extends State<ConsultProductsScreen> {
  final ProductoService _productoService = ProductoService();
  late Future<List<Producto>> _productosFuture;

  @override
  void initState() {
    super.initState();
    _productosFuture = _productoService.consultarProductos();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Center(
      child: SizedBox(
        height: size.height,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 20),
              Center(
                child: Text(
                  'Productos',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: kPrimaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: 450,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: const [
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    'Nombre',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Cantidad',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    'Estado',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    'Acciones',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: FutureBuilder<List<Producto>>(
                            future: _productosFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (snapshot.hasError) {
                                return Center(
                                  child: Text('Error: ${snapshot.error}'),
                                );
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.isEmpty) {
                                return const Center(
                                  child: Text('No hay productos disponibles.'),
                                );
                              }

                              final productos = snapshot.data!;

                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: productos.length,
                                itemBuilder: (context, index) {
                                  final producto = productos[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 4.0,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey.shade300,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 4,
                                            child: Text(producto.nombre),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              producto.cantidad.toString(),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Text(producto.nombreEstado),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                IconButton(
                                                  icon: const Icon(
                                                    Icons.edit,
                                                    color: kPrimaryColor,
                                                  ),
                                                  tooltip: 'Editar',
                                                  onPressed: () {
                                                    // lógica para editar producto
                                                    ScaffoldMessenger.of(
                                                      context,
                                                    ).showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          'Editar producto: ${producto.nombre}',
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                IconButton(
                                                  icon: const Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  ),
                                                  tooltip: 'Eliminar',
                                                  onPressed: () async {
                                                    final confirm = await showDialog<
                                                      bool
                                                    >(
                                                      context: context,
                                                      builder:
                                                          (
                                                            context,
                                                          ) => AlertDialog(
                                                            title: const Text(
                                                              'Confirmación',
                                                            ),
                                                            content: const Text(
                                                              '¿Está seguro de eliminar este producto?',
                                                            ),
                                                            actions: [
                                                              TextButton(
                                                                onPressed:
                                                                    () => Navigator.pop(
                                                                      context,
                                                                      false,
                                                                    ),
                                                                child:
                                                                    const Text(
                                                                      'No',
                                                                    ),
                                                              ),
                                                              TextButton(
                                                                onPressed:
                                                                    () => Navigator.pop(
                                                                      context,
                                                                      true,
                                                                    ),
                                                                child:
                                                                    const Text(
                                                                      'Sí',
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                    );

                                                    if (confirm == true) {
                                                      // lógica para eliminar producto
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
