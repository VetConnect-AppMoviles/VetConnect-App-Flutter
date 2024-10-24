import 'package:flutter/material.dart';

class VetClinicCard extends StatelessWidget {
  const VetClinicCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5), // Sombra
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Primera fila: Título de la clínica
          const Text(
            'Clínica Veterinaria - El Roble',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),

          // Segunda fila: Rating e imagen en una columna, y detalles en otra columna
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Primera columna: Rating e imagen
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Rating
                  Row(
                    children: const [
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      Icon(Icons.star_half, color: Colors.amber, size: 20),
                      SizedBox(width: 8),
                      Text(
                        '233 Reviews',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Imagen de la clínica
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      'assets/images/veterinarians_picture.png',
                      height: 120,
                      width: 180,
                      fit: BoxFit.cover, // Ajusta la imagen
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 16), // Espacio entre las dos columnas

              // Segunda columna: Dirección y precios
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Dirección: Jr Callao Nro 894, Callao',
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Consulta clínica: S/ 60',
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Baño: S/ 30',
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: Scaffold(
      body: Center(
        child: VetClinicCard(),
      ),
    ),
  ));
}
