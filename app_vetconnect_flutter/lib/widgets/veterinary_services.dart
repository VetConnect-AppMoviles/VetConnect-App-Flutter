import 'package:flutter/material.dart';

class VeterinaryServices extends StatelessWidget {
  const VeterinaryServices({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390, // Ajusta el ancho de tu contenedor
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Servicios',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
          const SizedBox(height: 16),

          // Servicios en varias columnas con un Wrap
          Wrap(
            spacing: 16.0, // Espacio horizontal entre columnas
            runSpacing: 8.0, // Espacio vertical entre filas
            children: List.generate(6, (index) {
              return SizedBox(
                width:
                150, // Ajusta el ancho de cada servicio para que se alineen en columnas
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Service #1', style: TextStyle(fontSize: 16)),
                    Text('S/. 60', style: TextStyle(fontSize: 16)),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
