import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/home_veterinary_appbar.dart';
import '../widgets/home_veterinary_buttons.dart';
import '../widgets/vet_clinic_card.dart';
import '../widgets/veterinary_description.dart';
import '../widgets/veterinary_opiniones.dart';
import '../widgets/veterinary_services.dart';

class HomeVeterinaryScreen2 extends StatefulWidget {
  const HomeVeterinaryScreen2({super.key});

  @override
  State<HomeVeterinaryScreen2> createState() => _HomeVeterinaryScreen2State();
}

class _HomeVeterinaryScreen2State extends State<HomeVeterinaryScreen2> {
  Map<String, dynamic>? vetCenter;

  @override
  void initState() {
    super.initState();
    fetchVetCenter();
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
              const CustomButtons(),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/home'),
                child: VetClinicCard(vetCenter: vetCenter!),
              ),
              const SizedBox(height: 16),
              VeterinaryDescription(description: vetCenter!['description']),
              const SizedBox(height: 16),
              VeterinaryServices(services: vetCenter!['services']),
              const SizedBox(height: 16),
              const VeterinaryOpinions(),
            ],
          ),
        ),
      ),
    );
  }
}
