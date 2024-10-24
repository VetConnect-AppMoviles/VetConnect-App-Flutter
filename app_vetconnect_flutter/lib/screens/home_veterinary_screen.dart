import 'package:app_vetconnect_flutter/widgets/home_veterinary_buttons.dart';
import 'package:app_vetconnect_flutter/widgets/schedule_clinic_card.dart';
import 'package:app_vetconnect_flutter/widgets/vet_clinic_card.dart';
import 'package:flutter/material.dart';
import 'package:app_vetconnect_flutter/widgets/home_veterinary_appbar.dart';

class HomeVeterinaryScreen extends StatefulWidget {
  @override
  _HomeVeterinaryScreenState createState() => _HomeVeterinaryScreenState();
}

class _HomeVeterinaryScreenState extends State<HomeVeterinaryScreen> {
  String? _selectedService;
  List<String> services = ['Consulta', 'Baño', 'Vacunación'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeVeterinaryAppBar(),
      body: SingleChildScrollView(
        // Aquí añadimos SingleChildScrollView para permitir el scroll
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // ---> Botones Pequeños Amarillos
              CustomButtons(),
              // ---> VeterinaryImageContainer
              VetClinicCard(),
              // Espacio entre los widgets
              // ---> Otros widgets como la clínica, horarios, etc.
              ScheduleCard(),
              // Imagen de la veterinaria
              SizedBox(
                height: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/images/pet_insurrance.png', // Asegúrate de que el archivo exista en esta ubicación
                  height: 120,
                  width: 350,
                  fit:
                  BoxFit.cover, // Ajusta la imagen al tamaño del contenedor
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: HomeVeterinaryScreen()));
