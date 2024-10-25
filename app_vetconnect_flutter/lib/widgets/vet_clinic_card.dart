import 'package:flutter/material.dart';

class VetClinicCard extends StatelessWidget {
  final Map<String, dynamic> vetCenter;

  const VetClinicCard({super.key, required this.vetCenter});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              vetCenter['imageProfile'],
              height: 120,
              width: 180,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  vetCenter['name'],
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Dirección: ${vetCenter['address']}',
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                ),
                const SizedBox(height: 8),
                Text(
                  'Consulta clínica: S/ ${vetCenter['services'][0]['price']}',
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                ),
                const SizedBox(height: 8),
                Text(
                  'Baño: S/ ${vetCenter['services'][1]['price']}',
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
