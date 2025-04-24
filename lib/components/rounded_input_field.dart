import 'package:flutter/material.dart';
import 'package:uni_favors/components/text_field_container.dart';
import 'package:uni_favors/constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final bool? enabled;

  const RoundedInputField({
    super.key,
    required this.hintText,
    required this.icon,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.focusNode,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        focusNode: focusNode,
        enabled: enabled,
        decoration: InputDecoration(
          icon: Icon(icon, color: kPrimaryColor),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
