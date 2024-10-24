import 'package:app_vetconnect_flutter/widgets/home_veterinary_appbar.dart';
import 'package:app_vetconnect_flutter/widgets/home_veterinary_buttons.dart';
import 'package:app_vetconnect_flutter/widgets/vet_clinic_card.dart';
import 'package:app_vetconnect_flutter/widgets/veterinary_description.dart';
import 'package:app_vetconnect_flutter/widgets/veterinary_opiniones.dart';
import 'package:app_vetconnect_flutter/widgets/veterinary_services.dart';
import 'package:flutter/material.dart';

// Asegúrate de importar los widgets que creaste

class HomeVeterinaryScreen2 extends StatefulWidget {
  const HomeVeterinaryScreen2({super.key});

  @override
  State<HomeVeterinaryScreen2> createState() => _HomeVeterinaryScreen2State();
}

class _HomeVeterinaryScreen2State extends State<HomeVeterinaryScreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeVeterinaryAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(
              16.0), // Opcional, para un poco de espacio alrededor
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              CustomButtons(),
              VetClinicCard(),
              VeterinaryDescription(), // Llamas al widget de descripción
              SizedBox(height: 16), // Espacio entre secciones
              VeterinaryServices(), // Llamas al widget de servicios
              SizedBox(height: 16), // Espacio entre secciones
              VeterinaryOpinions(), // Llamas al widget de opiniones
            ],
          ),
        ),
      ),
    );
  }
}
