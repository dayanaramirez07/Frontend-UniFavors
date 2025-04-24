import 'package:flutter/material.dart';
import 'package:uni_favors/screens/configuration/configuration_screen.dart';
import 'package:uni_favors/screens/consult_users/consult_screen.dart';
import 'components/header.dart';
import 'package:uni_favors/constants.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _screens = [
    Column(
      children: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Header(),
        ),
        Expanded(child: Center(child: Text("Pantalla Inicio"))),
      ],
    ),
    ConsultScreen(),
    ConfigurationScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: _screens,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kPrimaryColor,
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.table_chart), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
        ],
      ),
    );
  }
}
