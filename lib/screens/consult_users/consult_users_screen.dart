import 'package:flutter/material.dart';
import 'package:uni_favors/constants.dart';
import 'package:uni_favors/models/usuario.dart';
import 'package:uni_favors/services/usuario_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConsultUsersScreen extends StatefulWidget {
  const ConsultUsersScreen({super.key});

  @override
  State<ConsultUsersScreen> createState() => _ConsultUsersScreenState();
}

class _ConsultUsersScreenState extends State<ConsultUsersScreen> {
  final UsuarioService _usuarioService = UsuarioService();
  late Future<List<Usuario>> _usuariosFuture;

  @override
  void initState() {
    super.initState();
    _usuariosFuture = _usuarioService.consultarUsuarios();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Center(
      child: SizedBox(
        height: size.height,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 20),
              Center(
                child: Text(
                  'Usuarios',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: kPrimaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: 450,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: const [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Tipo',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    'Nombre',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    'Correo',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Acciones',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: FutureBuilder<List<Usuario>>(
                            future: _usuariosFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (snapshot.hasError) {
                                return Center(
                                  child: Text('Error: ${snapshot.error}'),
                                );
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.isEmpty) {
                                return const Center(
                                  child: Text('No hay usuarios disponibles.'),
                                );
                              }

                              final usuarios = snapshot.data!;

                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: usuarios.length,
                                itemBuilder: (context, index) {
                                  final usuario = usuarios[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 4.0,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey.shade300,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Text(usuario.tipoNombre),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Text(usuario.nombreUsuario),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: Text(usuario.correo),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: IconButton(
                                              icon: const Icon(
                                                Icons.block,
                                                color: kPrimaryColor,
                                              ),
                                              tooltip: 'Deshabilitar',
                                              onPressed: () async {
                                                final confirm = await showDialog<
                                                  bool
                                                >(
                                                  context: context,
                                                  builder:
                                                      (context) => AlertDialog(
                                                        title: const Text(
                                                          'Confirmación',
                                                        ),
                                                        content: const Text(
                                                          '¿Está seguro de deshabilitar este usuario?',
                                                        ),
                                                        actions: [
                                                          TextButton(
                                                            onPressed:
                                                                () =>
                                                                    Navigator.pop(
                                                                      context,
                                                                      false,
                                                                    ),
                                                            child: const Text(
                                                              'No',
                                                            ),
                                                          ),
                                                          TextButton(
                                                            onPressed:
                                                                () =>
                                                                    Navigator.pop(
                                                                      context,
                                                                      true,
                                                                    ),
                                                            child: const Text(
                                                              'Sí',
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                );

                                                if (confirm == true) {
                                                  final prefs =
                                                      await SharedPreferences.getInstance();
                                                  final token =
                                                      prefs.getString(
                                                        'token',
                                                      ) ??
                                                      '';

                                                  final exito =
                                                      await _usuarioService
                                                          .deshabilitarUsuario(
                                                            usuario.id!,
                                                            token,
                                                          );

                                                  if (!context.mounted) return;

                                                  if (exito) {
                                                    ScaffoldMessenger.of(
                                                      context,
                                                    ).showSnackBar(
                                                      const SnackBar(
                                                        content: Text(
                                                          'Usuario deshabilitado',
                                                        ),
                                                      ),
                                                    );

                                                    setState(() {
                                                      _usuariosFuture =
                                                          _usuarioService
                                                              .consultarUsuarios();
                                                    });
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                      context,
                                                    ).showSnackBar(
                                                      const SnackBar(
                                                        content: Text(
                                                          'Error al deshabilitar el usuario',
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
