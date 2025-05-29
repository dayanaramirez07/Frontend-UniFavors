import 'package:flutter/material.dart';
import 'package:uni_favors/components/rounded_input_field.dart';
import 'package:uni_favors/components/rounded_dropdown.dart';
import 'package:uni_favors/components/validators.dart';
import 'package:uni_favors/screens/business/components/business_state.dart';
import 'package:uni_favors/components/focus_listeners.dart';
import 'package:uni_favors/components/image_picker_box.dart';

class BusinessForm extends StatefulWidget {
  final BusinessFormStateManager state;
  final void Function(bool isValid)? onFormUpdated;

  const BusinessForm({super.key, required this.state, this.onFormUpdated});

  @override
  State<BusinessForm> createState() => _BusinessFormState();
}

class _BusinessFormState extends State<BusinessForm> {
  BusinessFormStateManager get state => widget.state;

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
      node: state.representanteFocus,
      onFocusLost: () {
        setState(() => state.representanteTocado = true);
        validarForm();
      },
    );

    attachFocusListener(
      node: state.logoFocus,
      onFocusLost: () {
        setState(() => state.logoTocado = true);
        validarForm();
      },
    );
  }

  void validarForm() {
    final valido = state.formKey.currentState?.validate() ?? false;
    final todosCamposLlenos =
        state.nombreController.text.isNotEmpty &&
        state.representanteController.text.isNotEmpty &&
        state.logoController.text.isNotEmpty;

    widget.onFormUpdated?.call(valido && todosCamposLlenos);
  }

  @override
  void dispose() {
    state.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: state.formKey,
      child: Column(
        children: [
          ImagePickerBox(
            label: "Seleccionar Logo",
            size: 180,
            initialPath: state.logoController.text,
            onImageSelected: (file, path) {
              setState(() {
                state.logoController.text = path;
              });
            },
          ),
          RoundedDropdown(
            hint: "Categoría",
            options: ['Belleza', 'Libros', 'Postres', 'Otra'],
            icon: Icons.category,
            onChanged: (value) {
              setState(() {
                state.categoriaSeleccionada = value;
              });
              validarForm();
            },
          ),
          RoundedInputField(
            hintText: "Nombre",
            icon: Icons.business,
            controller: state.nombreController,
            focusNode: state.nombreFocus,
            validator: (val) => !state.nombreTocado ? null : validarCampo(val),
          ),
          RoundedInputField(
            hintText: "Representante",
            icon: Icons.person,
            controller: state.representanteController,
            focusNode: state.representanteFocus,
            validator:
                (val) => !state.representanteTocado ? null : validarCampo(val),
          ),
        ],
      ),
    );
  }
}
