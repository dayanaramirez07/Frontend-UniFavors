import 'package:flutter/material.dart';
import 'package:uni_favors/constants.dart';
import 'package:uni_favors/components/custom_card.dart';
import 'package:uni_favors/models/negocio.dart';
import 'package:uni_favors/services/negocio_service.dart';

class BusinessListScreen extends StatefulWidget {
  final void Function(int negocioId) onNegocioSelected;
  const BusinessListScreen({super.key, required this.onNegocioSelected});

  @override
  State<BusinessListScreen> createState() => _BusinessListScreenState();
}

class _BusinessListScreenState extends State<BusinessListScreen> {
  final NegocioService _negocioService = NegocioService();
  late Future<List<Negocio>> _negociosFuture;

  @override
  void initState() {
    super.initState();
    _negociosFuture = _negocioService.consultarNegocios();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Center(
      child: SizedBox(
        height: size.height,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20),
                Text(
                  'Negocios/Emprendimientos',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: kPrimaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                FutureBuilder<List<Negocio>>(
                  future: _negociosFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    final negocios = snapshot.data!;
                    if (negocios.isEmpty) {
                      return const Center(child: Text('No hay negocios'));
                    }
                    return Column(
                      children:
                          negocios.map((neg) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: CustomCard(
                                title: Text(
                                  neg.nombre,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  'Representante: ${neg.representante}',
                                ),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Categoría: ${neg.nombreCategoria}'),
                                    Text('Contacto: ${neg.contacto}'),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed:
                                        () => widget.onNegocioSelected(neg.id!),
                                    child: const Text(
                                      'Ver productos',
                                      style: TextStyle(color: kPrimaryColor),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
