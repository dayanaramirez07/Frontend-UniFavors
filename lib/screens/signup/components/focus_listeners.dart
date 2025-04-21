import 'package:flutter/material.dart';

typedef OnFocusLostCallback = void Function();

void attachFocusListener({
  required FocusNode node,
  required VoidCallback onFocusLost,
}) {
  node.addListener(() {
    if (!node.hasFocus) {
      onFocusLost();
    }
  });
}
