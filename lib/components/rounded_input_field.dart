import 'package:flutter/material.dart';
import 'package:uni_favors/components/text_field_container.dart';
import 'package:uni_favors/constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    super.key,
    required this.hintText,
    required this.icon,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          icon: Icon(icon, color: kPrimaryColor),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
