import 'package:flutter/material.dart';
import 'package:app_vetconnect_flutter/widgets/home_veterinary_appbar.dart';
import 'package:app_vetconnect_flutter/widgets/vet_clinic_card.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Para usar jsonEncode

class HomeVeterinaryScreen3 extends StatefulWidget {
  final String service;  // Recibimos el parámetro de servicio
  final String time;     // Recibimos el parámetro de hora

  const HomeVeterinaryScreen3({
    super.key,
    required this.service,
    required this.time,
  });

  @override
  State<HomeVeterinaryScreen3> createState() => _HomeVeterinaryScreen3State();
}

class _HomeVeterinaryScreen3State extends State<HomeVeterinaryScreen3> {
  final TextEditingController _additionalInfoController = TextEditingController(); // Controlador para capturar la información adicional
  Map<String, dynamic>? bookingInfo; // Para guardar la información del booking

  // Método para hacer el GET de bookings
  Future<void> _fetchBookingInfo() async {
    try {
      final url = Uri.parse('https://my-json-server.typicode.com/RodrLH/vetconnect-jsonserver/bookings');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> bookings = jsonDecode(response.body); // Parsear la respuesta
        if (bookings.isNotEmpty) {
          setState(() {
            bookingInfo = bookings.first; // Tomar la primera reserva como ejemplo
          });
        }
      } else {
        print('Error al obtener la información de las reservas: ${response.body}');
      }
    } catch (error) {
      print('Error de red o de servidor: $error');
    }
  }

  // Método para hacer el POST (confirmación de reserva)
  Future<void> _confirmBooking() async {
    // Convertir la fecha y hora en formato ISO 8601
    final String dateTimeISO = DateTime.now().toIso8601String(); // Hora actual en formato ISO

    // Crear los datos del booking
    final bookingData = {
      "petOwnerId": 2, // ID del dueño (puedes cambiarlo dinámicamente)
      "vetCenterId": 1, // ID del centro veterinario (puedes cambiarlo dinámicamente)
      "serviceType": widget.service.toUpperCase(), // Convertir el servicio a mayúsculas
      "bookingDetails": {
        "appointmentDateTime": dateTimeISO, // Usar la hora actual
        "additionalInfo": _additionalInfoController.text // Información adicional escrita por el usuario
      },
      "price": 60, // Precio fijo, puedes cambiarlo si es necesario
      "bookingDate": dateTimeISO, // Fecha de la reserva en formato ISO
    };

    try {
      // Hacer el POST al servidor
      final url = Uri.parse('https://my-json-server.typicode.com/RodrLH/vetconnect-jsonserver/bookings');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(bookingData),
      );

      // Verificar si el POST fue exitoso
      if (response.statusCode == 201 || response.statusCode == 200) {
        print('Reserva confirmada exitosamente');
        Navigator.pushNamed(context, '/payment'); // Navegar a la pantalla de pago
      } else {
        print('Error al confirmar la reserva: ${response.body}');
        _showErrorDialog('Error al confirmar la reserva, intenta de nuevo.');
      }
    } catch (error) {
      print('Error de red o de servidor: $error');
      _showErrorDialog('Error de red, por favor verifica tu conexión e intenta nuevamente.');
    }
  }

  // Método para mostrar un diálogo de error
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchBookingInfo(); // Llamar para obtener la información de bookings
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeVeterinaryAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Mostrar la tarjeta de la clínica
              const VetClinicCard(),
              const SizedBox(height: 16),

              // Aquí empieza la información dinámica de "ServiceInformationCard"
              Container(
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Título
                    const Text(
                      'Información del Servicio',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Información del servicio y hora seleccionada
                    if (bookingInfo != null) ...[
                      // Mostrar los datos obtenidos de bookings
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Servicio:', style: TextStyle(fontSize: 16)),
                          Text(bookingInfo!['serviceType'],
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 8),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Fecha y Hora:', style: TextStyle(fontSize: 16)),
                          Text(bookingInfo!['bookingDetails']['appointmentDateTime'],
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 8),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Información adicional:', style: TextStyle(fontSize: 16)),
                          Text(bookingInfo!['bookingDetails']['additionalInfo'],
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 8),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Precio:', style: TextStyle(fontSize: 16)),
                          Text('S/. ${bookingInfo!['price']}',
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ] else ...[
                      const Center(child: CircularProgressIndicator()), // Mostrar un indicador de carga
                    ],

                    const SizedBox(height: 16),

                    // Botón de confirmación
                    ElevatedButton(
                      onPressed: _confirmBooking, // Llamar al método de confirmación
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Confirmar',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
