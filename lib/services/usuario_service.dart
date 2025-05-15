import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uni_favors/constants.dart';
import 'package:uni_favors/models/usuario.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class UsuarioService {
  final String urlLogin = '${environment}api/auth';
  final String urlUsuario = '${environment}api/usuarios';

  Future<List<Usuario>> consultarUsuarios() async {
    final response = await http.get(Uri.parse(urlUsuario));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((usuario) => Usuario.fromJson(usuario)).toList();
    } else {
      throw Exception('Error al cargar los usuarios');
    }
  }

  Future<int?> obtenerIdUsuarioDesdeToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) return null;

    try {
      final payload = JwtDecoder.decode(token);
      final sub = payload['sub'];

      if (sub is int) {
        return sub;
      } else if (sub is String) {
        return int.tryParse(sub);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<Usuario> consultarUsuarioPorId(int id) async {
    String basicAuth = 'Basic ${base64Encode(utf8.encode('user:password'))}';

    final response = await http.get(
      Uri.parse('$urlUsuario/$id'),
      headers: {'Authorization': basicAuth},
    );

    if (response.statusCode == 200) {
      return Usuario.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al cargar el usuario');
    }
  }

  Future<void> crearUsuario(Usuario usuario) async {
    String basicAuth = 'Basic ${base64Encode(utf8.encode('user:password'))}';

    final response = await http.post(
      Uri.parse(urlUsuario),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': basicAuth,
      },
      body: json.encode(usuario.toJson()),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Error al crear el usuario: ${response.body}');
    }
  }

  Future<bool> deshabilitarUsuario(int id, String token) async {
    final url = Uri.parse('$urlUsuario/$id/deshabilitar');

    final response = await http.put(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> login(String usuario, String contrasena) async {
    final response = await http.post(
      Uri.parse('$urlLogin/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({'identificador': usuario, 'contraseña': contrasena}),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      final token = responseData['token'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);

      return true;
    } else {
      return false;
    }
  }
}
