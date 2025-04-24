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
    ];

    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.1),
              LayoutBuilder(
                builder: (context, constraints) {
                  double columnWidth = constraints.maxWidth / 5;

                  return SingleChildScrollView(
                    child: DataTable(
                      columnSpacing: 12,
                      headingRowColor: WidgetStateProperty.all(
                        Colors.grey.shade200,
                      ),
                      headingTextStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      columns: [
                        DataColumn(
                          label: SizedBox(
                            width: columnWidth - 5,
                            child: Text('Tipo de Usuario', softWrap: true),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: columnWidth + 5,
                            child: Text('Nombre', softWrap: true),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: columnWidth + 10,
                            child: Text('Correo Institucional', softWrap: true),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: columnWidth,
                            child: Text('Acciones', softWrap: true),
                          ),
                        ),
                      ],
                      rows:
                          usuarios.map((usuario) {
                            return DataRow(
                              cells: [
                                DataCell(
                                  SizedBox(
                                    width: columnWidth - 5,
                                    child: Text(
                                      usuario['tipo']!,
                                      softWrap: true,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  SizedBox(
                                    width: columnWidth + 5,
                                    child: Text(
                                      usuario['nombre']!,
                                      softWrap: true,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  SizedBox(
                                    width: columnWidth + 10,
                                    child: Text(
                                      usuario['correo']!,
                                      softWrap: true,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  SizedBox(
                                    width: columnWidth,
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.block,
                                        color: kPrimaryColor,
                                      ),
                                      tooltip: 'Deshabilitar',
                                      onPressed: () async {
                                        final confirm = await showDialog<bool>(
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
                                          // Lógica
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                    ),
                  );
                },
              ),
              SizedBox(height: size.height * 0.1),
            ],
          ),
        ),
      ),
    );
  }
}
