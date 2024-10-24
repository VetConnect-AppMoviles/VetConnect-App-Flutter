import 'package:flutter/material.dart';

class HomeVeterinaryAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF54D8B4), // Color de fondo personalizado
      // ---> Boton de Regreso
      leading: IconButton(
        icon: const Icon(Icons.arrow_back,
            color: Colors.yellow), // Icono de regreso
        onPressed: () {
          Navigator.pop(context); // Acción para regresar
        },
      ),
      // ---> Imagen VET CONNECT
      title: Row(
        children: [
          Image.asset(
            'assets/images/logo.png', // Ruta del logo completo con texto "Vet Connect"
            height: 60,
            width: 160, // Ajusta según el tamaño de tu imagen
          ),
        ],
      ),
      // ---> Imagen del USUARIO
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: GestureDetector(
            onTap: () {
              // Acción para la imagen de perfil
              print("Foto de perfil pulsada");
            },
            child: CircleAvatar(
              backgroundImage: AssetImage(
                  'assets/images/user_picture.png'), // Ruta de la imagen de perfil
              radius: 20,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); // Define el tamaño del AppBar
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: HomeVeterinaryAppBar(),
      body: Center(child: Text("Pantalla principal")),
    ),
  ));
}
