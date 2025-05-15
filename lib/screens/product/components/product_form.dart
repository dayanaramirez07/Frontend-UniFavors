import 'package:flutter/material.dart';
import 'package:uni_favors/components/rounded_input_field.dart';
import 'package:uni_favors/components/rounded_dropdown.dart';
import 'package:uni_favors/components/validators.dart';
import 'package:uni_favors/screens/product/components/product_state.dart';
import 'package:uni_favors/components/focus_listeners.dart';
import 'package:uni_favors/components/image_picker_box.dart';

class ProductForm extends StatefulWidget {
  final void Function(bool isValid)? onFormUpdated;

  const ProductForm({super.key, this.onFormUpdated});

  @override
  State<ProductForm> createState() => _BusinessFormState();
}

class _BusinessFormState extends State<ProductForm> {
  final state = ProductFormStateManager();

  @override
  void initState() {
    super.initState();

    attachFocusListener(
      node: state.nombreFocus,
      onFocusLost: () {
        setState(() => state.nombreTocado = true);
        validarForm();
      },
    );

    attachFocusListener(
      node: state.descripcionFocus,
      onFocusLost: () {
        setState(() => state.descripcionTocado = true);
        validarForm();
      },
    );

    attachFocusListener(
      node: state.cantidadFocus,
      onFocusLost: () {
        setState(() => state.cantidadTocado = true);
        validarForm();
      },
    );

    attachFocusListener(
      node: state.precioFocus,
      onFocusLost: () {
        setState(() => state.precioTocado = true);
        validarForm();
      },
    );

    attachFocusListener(
      node: state.imagenFocus,
      onFocusLost: () {
        setState(() => state.imagenTocado = true);
        validarForm();
      },
    );
  }

  void validarForm() {
    final valido = state.formKey.currentState?.validate() ?? false;
    final todosCamposLlenos =
        state.nombreController.text.isNotEmpty &&
        state.descripcionController.text.isNotEmpty &&
        state.cantidadController.text.isNotEmpty &&
        state.precioController.text.isNotEmpty &&
        state.imagenController.text.isNotEmpty;

    widget.onFormUpdated?.call(valido && todosCamposLlenos);
  }

  @override
  void dispose() {
    state.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Form(
      key: state.formKey,
      child: Column(
        children: [
          ImagePickerBox(
            label: "Seleccionar Imagen",
            size: 180,
            initialPath: state.imagenController.text,
            onImageSelected: (file, path) {
              setState(() {
                state.imagenController.text = path;
              });
            },
          ),
          SizedBox(
            height: size.height * 0.36,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  RoundedDropdown(
                    hint: "Estado",
                    options: ['Disponible', 'Bajo Demanda'],
                    icon: Icons.info,
                    onChanged: (value) {
                      setState(() {
                        state.estadoSeleccionado = value;
                      });
                      validarForm();
                    },
                  ),
                  RoundedInputField(
                    hintText: "Nombre",
                    icon: Icons.shopping_bag,
                    controller: state.nombreController,
                    focusNode: state.nombreFocus,
                    validator:
                        (val) =>
                            !state.nombreTocado ? null : validarCorreo(val),
                  ),
                  RoundedInputField(
                    hintText: "Descripción",
                    icon: Icons.description,
                    controller: state.descripcionController,
                    focusNode: state.descripcionFocus,
                    validator:
                        (val) =>
                            !state.descripcionTocado ? null : validarCampo(val),
                  ),
                  RoundedInputField(
                    hintText: "Cantidad",
                    icon: Icons.numbers,
                    keyboardType: TextInputType.number,
                    controller: state.cantidadController,
                    focusNode: state.cantidadFocus,
                    enabled: state.estadoSeleccionado != 'Bajo Demanda',
                    validator: (val) {
                      if (state.estadoSeleccionado == 'Bajo Demanda') {
                        return null;
                      }
                      return !state.cantidadTocado ? null : validarCampo(val);
                    },
                  ),
                  RoundedInputField(
                    hintText: "Precio",
                    icon: Icons.attach_money,
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    controller: state.precioController,
                    focusNode: state.precioFocus,
                    validator:
                        (val) => !state.precioTocado ? null : validarCampo(val),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
