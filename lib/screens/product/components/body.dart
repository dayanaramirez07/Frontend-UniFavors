import 'package:flutter/material.dart';
import 'package:uni_favors/constants.dart';
import 'package:uni_favors/components/rounded_button.dart';
import 'package:uni_favors/models/producto.dart';
import 'package:uni_favors/screens/product/components/product_controller.dart';
import 'package:uni_favors/screens/product/components/product_form.dart';
import 'package:uni_favors/screens/product/components/product_state.dart';

class Body extends StatefulWidget {
  final Producto? producto;
  const Body({super.key, this.producto});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late final ProductFormStateManager state;
  final productController = ProductController();
  bool _isLoading = false;

  bool isFormValido = false;

  @override
  void initState() {
    super.initState();
    state = ProductFormStateManager();

    final p = widget.producto;
    if (p != null) {
      state.nombreController.text = p.nombre;
      state.descripcionController.text = p.descripcion;
      state.cantidadController.text = p.cantidad.toString();
      state.precioController.text = p.precio.toString();
      state.imagenController.text = p.imagen;
      state.estadoSeleccionado = p.nombreEstado;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                const SizedBox(height: 20),
                Text(
                  widget.producto == null
                      ? 'Nuevo Producto'
                      : 'Editar Producto',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: kPrimaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ProductForm(
                  state: state,
                  onFormUpdated:
                      (valido) => setState(() => isFormValido = valido),
                ),
                const SizedBox(height: 10),
                RoundedButton(
                  text:
                      _isLoading
                          ? 'Cargando...'
                          : (widget.producto == null ? 'CREAR' : 'ACTUALIZAR'),
                  press: (!_isLoading && isFormValido) ? _onSubmit : null,
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

  Future<void> _onSubmit() async {
    if (!(state.formKey.currentState?.validate() ?? false)) return;
    setState(() => _isLoading = true);
    try {
      if (widget.producto == null) {
        await productController.handleCrearProducto(
          context: context,
          formKey: state.formKey,
          nombreController: state.nombreController,
          descripcionController: state.descripcionController,
          cantidadController: state.cantidadController,
          precioController: state.precioController,
          imagenController: state.imagenController,
          estadoSeleccionado: state.estadoSeleccionado,
        );
      } else {
        await productController.handleActualizarProducto(
          context: context,
          id: widget.producto!.id!,
          formKey: state.formKey,
          nombreController: state.nombreController,
          descripcionController: state.descripcionController,
          cantidadController: state.cantidadController,
          precioController: state.precioController,
          imagenController: state.imagenController,
          estadoSeleccionado: state.estadoSeleccionado,
        );
      }
      if (!mounted) return;
      Navigator.of(context).pop(true);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
}
