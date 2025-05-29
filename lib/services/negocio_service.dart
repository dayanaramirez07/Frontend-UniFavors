import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uni_favors/constants.dart';
import 'package:uni_favors/models/negocio.dart';

class NegocioService {
  final String urlNegocio = '${environment}api/negocios';

  Future<List<Negocio>> consultarNegocios() async {
    String basicAuth = 'Basic ${base64Encode(utf8.encode('user:password'))}';

    final response = await http.get(
      Uri.parse(urlNegocio),
      headers: {'Authorization': basicAuth},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((negocio) => Negocio.fromJson(negocio)).toList();
    } else {
      throw Exception('Error al cargar los negocios');
    }
  }

  Future<void> crearNegocio(Negocio negocio) async {
    final response = await http.post(
      Uri.parse(urlNegocio),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(negocio.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Error al crear el Negocio');
    }
  }
}
