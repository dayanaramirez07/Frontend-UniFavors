import 'package:flutter/material.dart';
import 'package:uni_favors/constants.dart';

class ConsultScreen extends StatelessWidget {
  const ConsultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final List<Map<String, String>> usuarios = [
      {
        'tipo': 'Vendedor',
        'nombre': 'Dayana Ramírez',
        'correo': 'dayana.ramirez@udea.edu.co',
      },
      {
        'tipo': 'Cliente',
        'nombre': 'Carlos Pérez',
        'correo': 'carlos.perez@udea.edu.co',
      },
      {
        'tipo': 'Compa',
        'nombre': 'Ana Gómez',
        'correo': 'ana.gomez@udea.edu.co',
      },
      {
        'tipo': 'Vendedor',
        'nombre': 'Dayana Ramírez',
        'correo': 'dayana.ramirez@udea.edu.co',
      },
      {
        'tipo': 'Cliente',
        'nombre': 'Carlos Pérez',
        'correo': 'carlos.perez@udea.edu.co',
      },
      {
        'tipo': 'Compa',
        'nombre': 'Ana Gómez',
        'correo': 'ana.gomez@udea.edu.co',
      },
      {
        'tipo': 'Vendedor',
        'nombre': 'Dayana Ramírez',
        'correo': 'dayana.ramirez@udea.edu.co',
      },
      {
        'tipo': 'Cliente',
        'nombre': 'Carlos Pérez',
        'correo': 'carlos.perez@udea.edu.co',
      },
      {
        'tipo': 'Compa',
        'nombre': 'Ana Gómez',
        'correo': 'ana.gomez@udea.edu.co',
      },
      {
        'tipo': 'Vendedor',
        'nombre': 'Dayana Ramírez',
        'correo': 'dayana.ramirez@udea.edu.co',
      },
      {
        'tipo': 'Cliente',
        'nombre': 'Carlos Pérez',
        'correo': 'carlos.perez@udea.edu.co',
      },
      {
        'tipo': 'Compa',
        'nombre': 'Ana Gómez',
        'correo': 'ana.gomez@udea.edu.co',
      },
      {
        'tipo': 'Vendedor',
        'nombre': 'Dayana Ramírez',
        'correo': 'dayana.ramirez@udea.edu.co',
      },
      {
        'tipo': 'Cliente',
        'nombre': 'Carlos Pérez',
        'correo': 'carlos.perez@udea.edu.co',
      },
      {
        'tipo': 'Compa',
        'nombre': 'Ana Gómez',
        'correo': 'ana.gomez@udea.edu.co',
      },
    ];

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
                          child: ListView.builder(
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
                                        child: Text(usuario['tipo']!),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Text(usuario['nombre']!),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Text(usuario['correo']!),
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
                                                            () => Navigator.pop(
                                                              context,
                                                              false,
                                                            ),
                                                        child: const Text('No'),
                                                      ),
                                                      TextButton(
                                                        onPressed:
                                                            () => Navigator.pop(
                                                              context,
                                                              true,
                                                            ),
                                                        child: const Text('Sí'),
                                                      ),
                                                    ],
                                                  ),
                                            );

                                            if (confirm == true) {
                                              // lógica para deshabilitar usuario
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
