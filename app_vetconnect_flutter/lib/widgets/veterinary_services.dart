import 'package:flutter/material.dart';

class VeterinaryServices extends StatelessWidget {
  final List<dynamic> services;

  const VeterinaryServices({super.key, required this.services});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
          ...services.map((service) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(service['name'], style: const TextStyle(fontSize: 16)),
                  Text('S/. ${service['price']}', style: const TextStyle(fontSize: 16)),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
