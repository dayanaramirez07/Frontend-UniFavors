import 'package:flutter/material.dart';
import 'package:uni_favors/models/negocio.dart';
import 'package:uni_favors/screens/business/business_screen.dart';
import 'package:uni_favors/screens/configuration/configuration_screen.dart';
import 'package:uni_favors/screens/consult_products/consult_products_screen.dart';
import 'package:uni_favors/screens/consult_users/consult_users_screen.dart';
import 'package:uni_favors/screens/product/product_screen.dart';
import 'components/header.dart';
import 'package:uni_favors/constants.dart';
import 'package:uni_favors/services/usuario_service.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  String? tipoUsuarioController;
  Negocio? negocioController;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    tipoUsuarioActual();
  }

  Future<void> tipoUsuarioActual() async {
    final id = await UsuarioService().obtenerIdUsuarioDesdeToken();
    if (id != null) {
      try {
        final usuario = await UsuarioService().consultarUsuarioPorId(id);
        setState(() {
          tipoUsuarioController = usuario.tipoNombre;
          negocioController = usuario.negocio;
          _loading = false;
        });
      } catch (e) {
        print('Error cargando usuario: $e');
        setState(() => _loading = false);
      }
    } else {
      setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (tipoUsuarioController == null) {
      return const Scaffold(
        body: Center(child: Text('Por favor, inicia sesión')),
      );
    }

    late final List<Widget> screens;
    late final List<BottomNavigationBarItem> items;

    switch (tipoUsuarioController) {
      case 'Admin':
        screens = [
          _buildHome('Panel Admin'),
          const ConsultUsersScreen(),
          const ConfigurationScreen(),
        ];
        items = const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Admin'),
          BottomNavigationBarItem(
            icon: Icon(Icons.table_chart),
            label: 'Usuarios',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Config'),
        ];
        break;

      case 'Cliente':
        screens = [
          _buildHome('Bienvenido, Cliente'),
          const ConfigurationScreen(),
        ];
        items = const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Config'),
        ];
        break;

      case 'Vendedor':
        if (negocioController != null) {
          screens = [
            const ConsultProductsScreen(),
            const ProductScreen(),
            const ConfigurationScreen(),
          ];
          items = const [
            BottomNavigationBarItem(
              icon: Icon(Icons.store),
              label: 'Productos',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'Crear'),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Config',
            ),
          ];
          break;
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => BusinessScreen()),
            );
          });
          return const SizedBox.shrink();
        }

      case 'Compa':
        screens = [_buildHome('Panel Compa'), const ConfigurationScreen()];
        items = const [
          BottomNavigationBarItem(icon: Icon(Icons.handshake), label: 'Compa'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Config'),
        ];
        break;

      default:
        screens = [
          Center(child: Text('Rol no reconocido: $tipoUsuarioController')),
        ];
        items = const [
          BottomNavigationBarItem(icon: Icon(Icons.error), label: 'Error'),
        ];
    }

    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: screens,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kPrimaryColor,
        currentIndex: _currentIndex,
        onTap: (idx) {
          setState(() => _currentIndex = idx);
          _pageController.jumpToPage(idx);
        },
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        items: items,
      ),
    );
  }

  Widget _buildHome(String title) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Header(),
        ),
        Expanded(child: Center(child: Text(title))),
      ],
    );
  }
}
