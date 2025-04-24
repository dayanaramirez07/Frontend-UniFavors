String? validarCorreo(String? value) {
  if (value == null || value.isEmpty) return 'Campo obligatorio';
  if (!value.endsWith('@udea.edu.co')) {
    return 'Debe ser el correo institucional';
  }
  return null;
}

String? validarContrasenna(String? value) {
  if (value == null || value.isEmpty) return 'Campo obligatorio';
  if (value.length < 8) return 'Debe tener al menos 8 caracteres';
  if (!RegExp(r'[A-Z]').hasMatch(value)) return 'Debe tener una mayúscula';
  if (!RegExp(r'[a-z]').hasMatch(value)) return 'Debe tener una minúscula';
  if (!RegExp(r'[0-9]').hasMatch(value)) return 'Debe tener un número';
  if (!RegExp(r'[!@#\\$&*~.,;:\-_]').hasMatch(value)) {
    return 'Debe tener un carácter especial';
  }
  return null;
}

String? validarCampo(String? value) =>
    value == null || value.isEmpty ? 'Campo obligatorio' : null;

String? validarConfirmacion(String? value, String contra) {
  if (value == null || value.isEmpty) return 'Campo obligatorio';
  if (value != contra) return 'Las contraseñas no coinciden';
  return null;
}
