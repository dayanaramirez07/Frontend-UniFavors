import 'package:flutter/material.dart';
import 'package:uni_favors/constants.dart';
import 'package:uni_favors/components/rounded_button.dart';
import 'package:uni_favors/screens/product/components/product_controller.dart';
import 'package:uni_favors/screens/product/components/product_form.dart';
import 'package:uni_favors/screens/product/components/product_state.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final state = ProductFormStateManager();
  final productController = ProductController();
  final bool _isLoading = false;

  bool isFormValido = false;

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
                  'Producto',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: kPrimaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                ProductForm(
                  state: state,
                  onFormUpdated: (valido) {
                    setState(() => isFormValido = valido);
                  },
                ),
                SizedBox(height: 10),
                RoundedButton(
                  text: _isLoading ? "Cargando..." : "CREAR",
                  press:
                      _isLoading
                          ? null
                          : () {
                            productController.handleCrearProducto(
                              context: context,
                              formKey: state.formKey,
                              nombreController: state.nombreController,
                              descripcionController:
                                  state.descripcionController,
                              cantidadController: state.cantidadController,
                              precioController: state.precioController,
                              imagenController: state.imagenController,
                              estadoSeleccionado: state.estadoSeleccionado,
                            );
                          },
                  color: isFormValido ? kPrimaryColor : Colors.grey,
                  border: isFormValido ? kPrimaryColor : Colors.grey,
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
