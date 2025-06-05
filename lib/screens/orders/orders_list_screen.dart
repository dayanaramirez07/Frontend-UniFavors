import 'package:flutter/material.dart';
import 'package:uni_favors/constants.dart';
import 'package:uni_favors/components/custom_card.dart';
import 'package:uni_favors/models/pedido.dart';

class OrdersListScreen extends StatefulWidget {
  const OrdersListScreen({super.key});

  @override
  State<OrdersListScreen> createState() => _OrdersListScreenState();
}

class _OrdersListScreenState extends State<OrdersListScreen> {
  final List<Pedido> pedidos = [
    Pedido(
      producto: 'Arequipe artesanal',
      negocio: 'Dulces El Paraíso',
      cantidad: 2,
      precio: 15000.0,
    ),
    Pedido(
      producto: 'Tamal tolimense',
      negocio: 'Comidas Típicas Dona Luz',
      cantidad: 1,
      precio: 10000.0,
    ),
    Pedido(
      producto: 'Camiseta personalizada',
      negocio: 'Estampados Creativos',
      cantidad: 3,
      precio: 35000.0,
    ),
  ];

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
                  'Pedidos',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: kPrimaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Column(
                  children:
                      pedidos.map((pedido) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: CustomCard(
                            title: Text(
                              pedido.producto,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(pedido.negocio),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Cantidad: ${pedido.cantidad}'),
                                Text('Precio: ${pedido.precio}'),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'Realizar favor',
                                  style: TextStyle(color: kPrimaryColor),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
