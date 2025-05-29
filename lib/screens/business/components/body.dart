import 'package:flutter/material.dart';
import 'package:uni_favors/constants.dart';
import 'package:uni_favors/components/rounded_button.dart';
import 'package:uni_favors/screens/business/components/business_controller.dart';
import 'package:uni_favors/screens/business/components/business_form.dart';
import 'package:uni_favors/screens/business/components/business_state.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final state = BusinessFormStateManager();
  final businessController = BusinessController();
  final bool _isLoading = false;

  bool isFormValido = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
              Text(
                'Negocio/Emprendimiento',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: kPrimaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              BusinessForm(
                state: state,
                onFormUpdated: (valido) {
                  setState(() => isFormValido = valido);
                },
              ),
              SizedBox(height: 10),
              RoundedButton(
                text: _isLoading ? "Cargando..." : "REGISTRAR",
                press:
                    _isLoading
                        ? null
                        : () {
                          businessController.handleCrearNegocio(
                            context: context,
                            formKey: state.formKey,
                            nombreController: state.nombreController,
                            representanteController:
                                state.representanteController,
                            logoController: state.logoController,
                            categoriaSeleccionada: state.categoriaSeleccionada,
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
    );
  }
}
