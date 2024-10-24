import 'package:flutter/material.dart';

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12.0), // Margen más pequeño
      padding: const EdgeInsets.all(12.0), // Padding más pequeño
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15), // Bordes menos redondeados
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8, // Menor sombra
            offset: const Offset(0, 4), // Sombra reducida
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Hoy - 05 Abril',
            style: TextStyle(
              fontSize: 16, // Texto más pequeño
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          // Horarios
          GridView.count(
            crossAxisCount: 3, // Tres columnas
            shrinkWrap: true,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 3.5, // Ajustar proporción de ancho a alto
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              TimeSlot(time: '8:00'),
              TimeSlot(time: '9:00'),
              TimeSlot(time: '10:00'),
              TimeSlot(time: '----', isAvailable: false),
              TimeSlot(time: '14:00', isAvailable: false),
              TimeSlot(time: '15:00'),
              TimeSlot(time: '16:00'),
              TimeSlot(time: '17:00'),
              TimeSlot(time: '18:00'),
            ],
          ),
          const SizedBox(height: 12),

          // Otra fila de horarios (repetición de la primera)
          const Text(
            'Hoy - 05 Abril',
            style: TextStyle(
              fontSize: 16, // Texto más pequeño
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          GridView.count(
            crossAxisCount: 3, // Tres columnas
            shrinkWrap: true,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 3.5, // Ajustar proporción de ancho a alto
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              TimeSlot(time: '8:00'),
              TimeSlot(time: '9:00'),
              TimeSlot(time: '10:00'),
              TimeSlot(time: '----', isAvailable: false),
              TimeSlot(time: '14:00', isAvailable: false),
              TimeSlot(time: '15:00'),
              TimeSlot(time: '16:00'),
              TimeSlot(time: '17:00'),
              TimeSlot(time: '18:00'),
            ],
          ),
        ],
      ),
    );
  }
}

class TimeSlot extends StatelessWidget {
  final String time;
  final bool isAvailable;

  const TimeSlot({
    required this.time,
    this.isAvailable = true,
  });

  @override
Widget build(BuildContext context) {
  return GestureDetector(
    onTap: isAvailable ? () => Navigator.pushNamed(context, '/home3') : null,
    child: Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
          vertical: 4.0), // Reducir el padding vertical
      decoration: BoxDecoration(
        color: isAvailable
            ? Colors.lightGreenAccent.withOpacity(0.2)
            : Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isAvailable
              ? Colors.lightGreenAccent.withOpacity(0.5)
              : Colors.grey.withOpacity(0.5),
        ),
      ),
      child: Text(
        time,
        style: TextStyle(
          fontSize: 14, // Tamaño de texto más pequeño
          color: isAvailable ? Colors.teal : Colors.grey,
        ),
      ),
    ),
  );
}

void main() {
  runApp(const MaterialApp(
    home: Scaffold(
      body: Center(
        child: ScheduleCard(),
      ),
    ),
  ));
}
}
