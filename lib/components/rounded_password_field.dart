import 'package:flutter/material.dart';
import 'package:uni_favors/components/text_field_container.dart';
import 'package:uni_favors/constants.dart';

class RoundedPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool showPassword;
  final VoidCallback togglePasswordVisibility;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;

  const RoundedPasswordField({
    super.key,
    required this.controller,
    required this.showPassword,
    required this.togglePasswordVisibility,
    this.hintText = "Contraseña",
    this.validator,
    this.onChanged,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        controller: controller,
        obscureText: !showPassword,
        validator: validator,
        focusNode: focusNode,
        onChanged: onChanged,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: hintText,
          icon: Icon(Icons.lock, color: kPrimaryColor),
          suffixIcon: IconButton(
            icon: Icon(
              showPassword ? Icons.visibility : Icons.visibility_off,
              color: kPrimaryColor,
            ),
            onPressed: togglePasswordVisibility,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
