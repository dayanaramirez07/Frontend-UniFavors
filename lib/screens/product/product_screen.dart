import 'package:flutter/material.dart';
import 'package:uni_favors/models/producto.dart';
import 'package:uni_favors/screens/product/components/body.dart';

class ProductScreen extends StatelessWidget {
  final Producto? producto;
  const ProductScreen({super.key, this.producto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Body(producto: producto));
  }
}
