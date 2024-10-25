import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/home_veterinary_appbar.dart';
import '../widgets/vet_clinic_card.dart';

class HomeVeterinaryScreen3 extends StatefulWidget {
  final String service;
  final String time;

  const HomeVeterinaryScreen3({super.key, required this.service, required this.time});

  @override
  _HomeVeterinaryScreen3State createState() => _HomeVeterinaryScreen3State();
}

class _HomeVeterinaryScreen3State extends State<HomeVeterinaryScreen3> {
  Map<String, dynamic>? vetCenter;
  Map<String, dynamic>? bookingInfo;

  @override
  void initState() {
    super.initState();
    fetchVetCenter();
    _fetchBookingInfo();
  }

  Future<void> fetchVetCenter() async {
    final response = await http.get(Uri.parse('https://my-json-server.typicode.com/RodrLH/vetconnect-jsonserver/vet-centers/1'));

    if (response.statusCode == 200) {
      setState(() {
        vetCenter = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load vet center');
    }
  }

  Future<void> _fetchBookingInfo() async {
    // Simulate fetching booking info
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      bookingInfo = {
        'serviceType': widget.service,
        'bookingDetails': {
          'appointmentDateTime': widget.time,
          'additionalInfo': 'Ninguna',
        },
        'price': '100',
      };
    });
  }

  Future<void> _confirmBooking() async {
    try {
      final response = await http.post(
        Uri.parse('https://my-json-server.typicode.com/RodrLH/vetconnect-jsonserver/bookings'),
        body: json.encode({
          'serviceType': widget.service,
          'appointmentDateTime': widget.time,
          'additionalInfo': 'Ninguna',
          'price': '100',
        }),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        print('Reserva confirmada exitosamente');
        Navigator.pushNamed(context, '/payment');
      } else {
        print('Error al confirmar la reserva: ${response.body}');
        _showErrorDialog('Error al confirmar la reserva, intenta de nuevo.');
      }
    } catch (error) {
      print('Error de red o de servidor: $error');
      _showErrorDialog('Error de red, por favor verifica tu conexión e intenta nuevamente.');
    }
  }

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
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeVeterinaryAppBar(),
      body: vetCenter == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VetClinicCard(vetCenter: vetCenter!),
              const SizedBox(height: 16),
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
                    const Text(
                      'Información del Servicio',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (bookingInfo != null) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Servicio:', style: TextStyle(fontSize: 16)),
                          Text(bookingInfo!['serviceType'],
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Fecha y Hora:', style: TextStyle(fontSize: 16)),
                          Text(bookingInfo!['bookingDetails']['appointmentDateTime'],
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Información adicional:', style: TextStyle(fontSize: 16)),
                          Text(bookingInfo!['bookingDetails']['additionalInfo'],
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Precio:', style: TextStyle(fontSize: 16)),
                          Text('S/. ${bookingInfo!['price']}',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ] else ...[
                      const Center(child: CircularProgressIndicator()),
                    ],
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _confirmBooking,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
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
