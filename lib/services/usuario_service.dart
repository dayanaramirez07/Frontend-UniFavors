import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uni_favors/constants.dart';
import 'package:uni_favors/models/usuario.dart';

class UsuarioService {
  final String baseUrl = '${environment}api/auth';

  Future<List<Usuario>> fetchUsuarios() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((usuario) => Usuario.fromJson(usuario)).toList();
    } else {
      throw Exception('Error al cargar los usuarios');
    }
  }

  Future<Usuario> fetchUsuarioById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      return Usuario.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al cargar el usuario');
    }
  }

  Future<void> createUsuario(Usuario usuario) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(usuario.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Error al crear el usuario');
    }
  }

  Future<bool> login(String usuario, String contrasena) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({'identificador': usuario, 'contraseña': contrasena}),
    );

    if (response.statusCode == 200) {
      return true; // Inicio de sesión exitoso
    } else {
      print("Error: ${response.statusCode}");
      print("Response: ${response.body}");
      return false; // Credenciales incorrectas
    }
  }
}
