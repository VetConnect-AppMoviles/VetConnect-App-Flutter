import 'package:app_vetconnect_flutter/widgets/home_veterinary_appbar.dart';
import 'package:app_vetconnect_flutter/widgets/service_information_card.dart';
import 'package:app_vetconnect_flutter/widgets/vet_clinic_card.dart';
import 'package:flutter/material.dart';
// Importar tus componentes

class HomeVeterinaryScreen3 extends StatefulWidget {
  const HomeVeterinaryScreen3({super.key});

  @override
  State<HomeVeterinaryScreen3> createState() => _HomeVeterinaryScreen3State();
}

class _HomeVeterinaryScreen3State extends State<HomeVeterinaryScreen3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeVeterinaryAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              VetClinicCard(), // Componente de la tarjeta de la clínica veterinaria
              SizedBox(height: 16), // Espacio entre los componentes
              ServiceInformationCard(), // Componente de la información del servicio
            ],
          ),
        ),
      ),
    );
  }
}
