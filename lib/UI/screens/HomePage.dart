import 'package:flutter/material.dart';
import 'VetInfoPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _vetCenters = [];

  @override
  void initState() {
    super.initState();
    _fetchVeterinaryClinics();
  }

  Future<void> _fetchVeterinaryClinics() async {
    final response = await http.get(
      Uri.parse('https://resilient-contentment-production.up.railway.app/api/vet-centers'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> clinics = json.decode(response.body);
      setState(() {
        _vetCenters = clinics.cast<Map<String, dynamic>>();
      });
    } else {
      throw Exception('Failed to load veterinary clinics');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _vetCenters.length,
                itemBuilder: (context, index) {
                  final vetCenter = _vetCenters[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VetInfoPage(vetCenter: vetCenter),
                        ),
                      );
                    },
                    child: SizedBox(
                      width: double.infinity,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Clínica Veterinaria - ${vetCenter['name']}',
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
                  );
                },
              ),
            ),
            Center(
              child: Image.asset(
                'assets/images/pet_insurrance.png',
                height: 200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}