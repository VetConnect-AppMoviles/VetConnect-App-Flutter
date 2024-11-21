import 'package:app_vetconnect/UI/widgets/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'PaymentPage.dart';

class RequestServicePage extends StatelessWidget {
  final Map<String, dynamic> vetCenter;
  final Map<String, dynamic> service;
  final int roleId; // Add roleId parameter
  final TextEditingController additionalInfoController = TextEditingController();

  RequestServicePage({super.key, required this.vetCenter, required this.service, required this.roleId});

  Future<void> _submitBooking(BuildContext context) async {
    if (roleId != 2) {
      // Show an error message if the user is not a pet-owner
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Only pet-owners can make bookings.')),
      );
      return;
    }

    final Map<String, dynamic> bookingDetails = {
      'id': 0,
      'petOwnerId': 0, // Replace with actual pet owner ID
      'vetCenterId': vetCenter['id'],
      'serviceType': service['name'],
      'appointmentDateTime': DateTime.now().toIso8601String(), // Replace with actual appointment date and time
      'additionalInfo': additionalInfoController.text,
      'price': service['price'],
      'bookingDate': DateTime.now().toIso8601String(),
    };

    final response = await http.post(
      Uri.parse('https://vetconnect-backend-production.up.railway.app/api/bookings'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(bookingDetails),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      print('Booking Submitted');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const PaymentPage(),
        ),
      );
    } else {
      print('Failed to submit booking');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onBackButtonPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xFFF4F4F4),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Clinic Info Card
              SizedBox(
                width: double.infinity,
                child: Card(
                  color: const Color(0xFFFFFFFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Clínicas Veterinaria - ${vetCenter['name']}',
                          style: const TextStyle(
                            color: Color(0xFF003333),
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Image.network(
                                vetCenter['imageProfile'],
                                height: 100,
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Dirección:',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    vetCenter['location'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Service Info Card
              SizedBox(
                width: double.infinity,
                child: Card(
                  color: const Color(0xFFFFFFFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Column(
                            children: [
                              Text(
                                'Información del',
                                style: TextStyle(
                                  color: Color(0xFFFF9900),
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'servicio',
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Color(0xFFFF9900),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF2E0),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        'Servicio:',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        service['name'],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        'Precio:',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        'S/. ${service['price']}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                const Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Información adicional:',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                TextField(
                                  controller: additionalInfoController,
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                    fillColor: const Color(0xFFFEFEFE),
                                    filled: true,
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.all(12.0),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Center(
                                  child: ElevatedButton(
                                    onPressed: () => _submitBooking(context),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF54D6B6),
                                      foregroundColor: const Color(0xFF176A56),
                                    ),
                                    child: const Text('Solicitar Servicio'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}