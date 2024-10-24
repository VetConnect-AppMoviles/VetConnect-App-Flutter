import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import '../models/booking.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Booking>> futureBookings;

  @override
  void initState() {
    super.initState();
    futureBookings = fetchBookings();
  }

  Future<List<Booking>> fetchBookings() async {
    final response = await http.get(Uri.parse('https://my-json-server.typicode.com/RodrLH/vetconnect-jsonserver/db'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final bookings = data['bookings'] as List;
      final users = {for (var user in data['users']) user['id'] as int: user['username'] as String};

      return bookings.map((booking) => Booking.fromJson(booking, users)).toList();
    } else {
      throw Exception('Failed to load bookings');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFBCFFEE),
      body: Column(
        children: [
          _buildHeader(context),
          const SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Próximas Citas',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: FutureBuilder<List<Booking>>(
                      future: futureBookings,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(child: Text('No hay citas disponibles'));
                        } else {
                          final bookings = snapshot.data!;
                          return ListView.builder(
                            itemCount: bookings.length,
                            itemBuilder: (context, index) {
                              final booking = bookings[index];
                              final formattedDate = DateFormat('EEEE, MMM d, yyyy').format(DateTime.parse(booking.appointmentDateTime));
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFF8EE),
                                    borderRadius: BorderRadius.circular(15),
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
                                      Image.asset(
                                        'assets/images/diagnostico.png',
                                        height: 40,
                                      ),
                                      const SizedBox(width: 16),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            booking.petOwnerName,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            formattedDate,
                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Column(
                                        children: [
                                          Image.asset(
                                            'assets/images/persona.png',
                                            height: 40,
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            DateFormat('h:mm a').format(DateTime.parse(booking.appointmentDateTime)),
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 20,
            color: const Color(0xFFBCFFEE),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: const Color(0xFF54D6B6),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 40,
            ),
            PopupMenuButton(
              child: Image.asset(
                'assets/images/veterinary_logo.png',
                height: 40,
              ),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'profile',
                  child: Text('Configuración de perfil'),
                ),
                const PopupMenuItem(
                  value: 'transactions',
                  child: Text('Transacciones'),
                ),
                const PopupMenuItem(
                  value: 'faq',
                  child: Text('FAQ & Policy Terms'),
                ),
                const PopupMenuItem(
                  value: 'logout',
                  child: Text('Cerrar sesión'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}