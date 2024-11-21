import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CustomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabChange;

  const CustomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF54D6B6),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 15,
        ),
        child: GNav(
          selectedIndex: selectedIndex,
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: const Color(0xFF40A28A),
          gap: 8,
          padding: const EdgeInsets.all(16),
          onTabChange: onTabChange,
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Inicio',
            ),
            GButton(
              icon: Icons.search,
              text: 'Buscar',
            ),
            GButton(
              icon: Icons.map,
              text: 'Mapa',
            ),
            GButton(
              icon: Icons.person,
              text: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }
}