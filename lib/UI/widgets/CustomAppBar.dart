import 'package:flutter/material.dart';

import '../screens/T&CPage.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onBackButtonPressed;

  const CustomAppBar({super.key, required this.onBackButtonPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF54D6B6),
      iconTheme: const IconThemeData(
        color: Color(0xFFFFBB57),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Color(0xFFFFBB57)),
        onPressed: onBackButtonPressed,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Spacer(),
          Center(
            child: Image.asset(
              'assets/images/logo.png',
              height: 50,
            ),
          ),
          const Spacer(),
          PopupMenuButton<String>(
            icon: const Icon(Icons.person, color: Color(0xFFFFBB57)),
            onSelected: (String result) {
              switch (result) {
                case 'Mis Citas':
                  // Navigate to Mis Citas page
                  break;
                case 'FAQ & T&C':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TCPage(),
                    ),
                  );
                  break;
                case 'Cerrar Sesión':
                  Navigator.pushNamed(context, '/');
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Mis Citas',
                child: Text('Mis Citas'),
              ),
              const PopupMenuItem<String>(
                value: 'FAQ & T&C',
                child: Text('FAQ & T&C'),
              ),
              const PopupMenuItem<String>(
                value: 'Cerrar Sesión',
                child: Text('Cerrar Sesión'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}