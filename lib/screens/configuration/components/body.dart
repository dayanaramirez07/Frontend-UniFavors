import 'package:flutter/material.dart';
import 'package:uni_favors/constants.dart';
import 'package:uni_favors/components/rounded_button.dart';
import 'package:uni_favors/screens/configuration/components/configuration_form.dart';
import 'package:uni_favors/screens/configuration/components/information.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isCelularValido = false;
  bool isContrasennaValida = false;

  bool get isFormValido => isCelularValido && isContrasennaValida;

  void actualizarValidezCelular(bool valido) {
    setState(() => isCelularValido = valido);
  }

  void actualizarValidezContrasenna(bool valido) {
    setState(() => isContrasennaValida = valido);
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20),
                Text(
                  'Información del usuario',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: kPrimaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                Information(onFormUpdated: actualizarValidezCelular),
                SizedBox(height: 10),
                Text(
                  'Actualizar contraseña',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: kPrimaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                ConfigurationForm(onFormUpdated: actualizarValidezContrasenna),
                SizedBox(height: 10),
                RoundedButton(
                  text: "ACTUALIZAR",
                  press: isFormValido ? () => print("Submit") : null,
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
