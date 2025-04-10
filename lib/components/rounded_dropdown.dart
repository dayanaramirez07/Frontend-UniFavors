import 'package:flutter/material.dart';
import 'package:uni_favors/components/text_field_container.dart';
import 'package:uni_favors/constants.dart';

class RoundedDropdown extends StatelessWidget {
  final String hint;
  final List<String> options;
  final ValueChanged<String?> onChanged;
  final IconData icon;

  const RoundedDropdown({
    super.key,
    required this.hint,
    required this.options,
    required this.onChanged,
    this.icon = Icons.person,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: DropdownButtonFormField<String>(
        onChanged: onChanged,
        decoration: InputDecoration(
          icon: Icon(icon, color: kPrimaryColor),
          border: InputBorder.none,
        ),
        hint: Text(hint),
        items:
            options.map((String value) {
              return DropdownMenuItem<String>(value: value, child: Text(value));
            }).toList(),
        dropdownColor: Colors.white,
        borderRadius: BorderRadius.circular(12),
        elevation: 2,
      ),
    );
  }
}
