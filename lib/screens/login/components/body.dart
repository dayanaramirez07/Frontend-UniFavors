import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uni_favors/components/already_have_un_account_check.dart';
import 'package:uni_favors/components/rounded_button.dart';
import 'package:uni_favors/constants.dart';
import 'package:uni_favors/screens/login/components/background.dart';
import 'package:uni_favors/screens/login/components/login_form.dart';
import 'package:uni_favors/screens/login/components/login_state.dart';
import 'package:uni_favors/screens/login/components/login_controller.dart';
import 'package:uni_favors/screens/signup/signup_screen.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final state = LoginFormStateManager();
  final loginController = LoginController();
  final bool _isLoading = false;

  @override
  void dispose() {
    state.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Background(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "INICIO DE SESIÓN",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: kPrimaryColor,
                      ),
                    ),
                    SizedBox(height: size.height * 0.04),
                    SvgPicture.asset(
                      "assets/icons/login.svg",
                      height: size.height * 0.35,
                    ),
                    SizedBox(height: size.height * 0.04),
                    LoginForm(state: state),
                    SizedBox(height: size.height * 0.02),
                    RoundedButton(
                      text: _isLoading ? "Cargando..." : "INGRESAR",
                      press:
                          _isLoading
                              ? null
                              : () {
                                loginController.handleLogin(
                                  context: context,
                                  formKey: state.formKey,
                                  usuarioController: state.usuarioController,
                                  contrasenaController:
                                      state.contrasennaController,
                                );
                              },
                    ),
                    SizedBox(height: size.height * 0.04),
                    AlreadyHaveUnAccountCheck(
                      login: true,
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignupScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
