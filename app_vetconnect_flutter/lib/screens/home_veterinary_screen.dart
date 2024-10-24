import 'package:app_vetconnect_flutter/widgets/vet_clinic_card.dart';
import 'package:flutter/material.dart';
import '../widgets/home_veterinary_appbar.dart';
import 'home_veterinary_screen3.dart'; // Asegúrate de importar HomeVeterinaryScreen3

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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Botones Pequeños Amarillos
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Botón de Servicios con Dropdown
                  SizedBox(
                    width: 100,
                    height: 30,
                    child: ElevatedButton(
                      onPressed: () {
                        _showServiceDropdown(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEED7BE),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _selectedService ?? 'Checkup',
                            style: const TextStyle(
                                fontSize: 10, color: Colors.black),
                          ),
                          const Icon(Icons.arrow_drop_down,
                              color: Colors.black),
                        ],
                      ),
                    ),
                  ),

                  // Botón de Ubicación
                  SizedBox(
                    width: 100,
                    height: 30,
                    child: ElevatedButton(
                      onPressed: () {
                        // Lógica del botón de Ubicación
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEED7BE),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      ),
                      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
                        Text(
                          'Ubicación',
                          style: TextStyle(fontSize: 10, color: Colors.black),
                        ),
                      ]),
                    ),
                  ),
                ],
              ),

              // VeterinaryImageContainer
              VetClinicCard(),

              // Espacio entre los widgets
              const SizedBox(height: 20),

              // Horarios con GridView
              Container(
                margin: const EdgeInsets.all(12.0),
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Hoy - 05 Abril',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Horarios
                    GridView.count(
                      crossAxisCount: 3,
                      shrinkWrap: true,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 3.5,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _buildTimeSlot(context, '8:00', true),
                        _buildTimeSlot(context, '9:00', true),
                        _buildTimeSlot(context, '10:00', true),
                        _buildTimeSlot(context, '14:00', false),
                        _buildTimeSlot(context, '15:00', true),
                        _buildTimeSlot(context, '16:00', true),
                        _buildTimeSlot(context, '17:00', true),
                        _buildTimeSlot(context, '18:00', true),
                      ],
                    ),
                  ],
                ),
              ),

              // Imagen de la veterinaria
              const SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/images/pet_insurrance.png',
                  height: 120,
                  width: 350,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Función para mostrar el menú desplegable de servicios
  void _showServiceDropdown(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: services.map((service) {
              return ListTile(
                title: Text(service),
                onTap: () {
                  setState(() {
                    _selectedService = service;
                  });
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  // Función para crear TimeSlot y pasar hora y servicio a la próxima pantalla
  Widget _buildTimeSlot(BuildContext context, String time, bool isAvailable) {
    return GestureDetector(
      onTap: isAvailable
          ? () {
        // Navegar a HomeVeterinaryScreen3 y pasar la hora y el servicio seleccionado
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeVeterinaryScreen3(
              service: _selectedService ?? 'Checkup',
              time: time,
            ),
          ),
        );
      }
          : null, // Si no está disponible, no hace nada
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 4.0),
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
            fontSize: 14,
            color: isAvailable ? Colors.teal : Colors.grey,
          ),
        ),
      ),
    );
  }
}
