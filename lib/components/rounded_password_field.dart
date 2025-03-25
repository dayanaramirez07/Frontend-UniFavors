import 'package:flutter/material.dart';
import 'package:uni_favors/components/text_field_container.dart';
import 'package:uni_favors/constants.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: "Contraseña",
          icon: Icon(Icons.lock, color: kPrimaryColor),
          suffixIcon: Icon(Icons.visibility, color: kPrimaryColor),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
