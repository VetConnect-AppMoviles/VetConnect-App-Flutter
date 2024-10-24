import 'package:flutter/material.dart';

class CustomButtons extends StatefulWidget {
  const CustomButtons({super.key});

  @override
  State<CustomButtons> createState() => _CustomButtonsState();
}

class _CustomButtonsState extends State<CustomButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
      MainAxisAlignment.spaceEvenly, // Espacio igual entre los botones
      children: [
        // Botón de Servicios
        SizedBox(
          width: 100, // Ancho del botón
          height: 30, // Altura del botón
          child: ElevatedButton(
            onPressed: () {
              // Lógica del botón de Servicios
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEED7BE), // Color beige claro
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // Bordes redondeados
              ),
              padding: const EdgeInsets.symmetric(
                  horizontal: 5, vertical: 5), // Padding interno del botón
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Servicios',
                  style: TextStyle(
                      fontSize: 10, color: Colors.black), // Color del texto
                ),
                Icon(Icons.arrow_drop_down,
                    color: Colors.black), // Icono desplegable
              ],
            ),
          ),
        ),

        // Botón de Ubicación
        SizedBox(
          width: 100, // Ancho del botón
          height: 30, // Altura del botón
          child: ElevatedButton(
            onPressed: () {
              // Lógica del botón de Ubicación
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEED7BE), // Color beige claro
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // Bordes redondeados
              ),

              padding: const EdgeInsets.symmetric(
                  horizontal: 5, vertical: 5), // Padding interno del botón
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                'Ubicación',
                style: TextStyle(
                    fontSize: 10, color: Colors.black), // Color del texto
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
