import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 20,
              child: SvgPicture.asset('assets/icons/chat.svg'),
            ),
            SizedBox(width: 10),
            Text('Hola, Nombre', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }
}
