import 'package:app_vetconnect_flutter/extra/home_veterinary_appbar.dart';
import 'package:flutter/material.dart';

class VeterinaryConfig extends StatelessWidget {
  const VeterinaryConfig({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeVeterinaryAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Imagen circular (veterinary_logo.png)
              CircleAvatar(
                radius: 80, // Tamaño de la imagen circular
                backgroundImage:
                AssetImage('assets/images/veterinary_logo.png'),
              ),
              const SizedBox(height: 16),

              // Botón Upload
              ElevatedButton(
                onPressed: () {
                  // Acción al presionar el botón
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(20), // Borde más redondeado
                  ),
                ),
                child: const Text(
                  'Upload',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              const SizedBox(height: 16),

              // Campo Address
              const CustomTextField(
                label: 'Address',
                hintText: 'Address',
                icon: Icons.edit,
              ),
              const SizedBox(height: 16),

              // Campo Password
              const CustomTextField(
                label: 'Password',
                hintText: '***********',
                icon: Icons.edit,
                obscureText: true,
              ),
              const SizedBox(height: 16),

              // Campo Mobile Number
              const CustomTextField(
                label: 'Mobile Number',
                hintText: '999 999 999',
                icon: Icons.edit,
              ),
              const SizedBox(height: 16),

              // Tabla de servicios
              const ServiceTable(),

              const SizedBox(height: 16),

              // Imágenes de servicios (imágenes de vet_config_1.png a vet_config_4.png)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      _showImageDialog(
                          context, 'assets/images/vet_config_1.png');
                    },
                    child: Image.asset('assets/images/vet_config_1.png',
                        width: 80, height: 80, fit: BoxFit.cover),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      _showImageDialog(
                          context, 'assets/images/vet_config_2.png');
                    },
                    child: Image.asset('assets/images/vet_config_2.png',
                        width: 80, height: 80, fit: BoxFit.cover),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      _showImageDialog(
                          context, 'assets/images/vet_config_3.png');
                    },
                    child: Image.asset('assets/images/vet_config_3.png',
                        width: 80, height: 80, fit: BoxFit.cover),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      _showImageDialog(
                          context, 'assets/images/vet_config_4.png');
                    },
                    child: Image.asset('assets/images/vet_config_4.png',
                        width: 80, height: 80, fit: BoxFit.cover),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Botones Añadir Servicio y Aceptar y Guardar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _showAddServiceDialog(
                          context); // Mostrar modal al tocar el botón
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(30), // Bordes redondeados
                      ),
                    ),
                    child: const Text(
                      'AÑADIR SERVICIO',
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Acción para aceptar y guardar
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(30), // Bordes redondeados
                      ),
                    ),
                    child: const Text(
                      'ACEPTAR Y GUARDAR',
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Método para mostrar el modal "Añadir Nuevo Servicio"
  void _showAddServiceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Color(0xFF38BCB4), // Color de fondo del modal
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'AÑADIR NUEVO SERVICIO',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Servicio',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    fillColor: Color(0xFFE0F7FA),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  hint: const Text('Escoge un servicio'),
                  items: ['Servicio 1', 'Servicio 2', 'Servicio 3']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {},
                ),
                const SizedBox(height: 16),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Precio',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: InputDecoration(
                    fillColor: Color(0xFFE0F7FA),
                    filled: true,
                    hintText: 'S/.',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Cerrar el modal
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        Color(0xFF083434), // Color oscuro del botón
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Cancelar',
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Lógica para aceptar y guardar el servicio
                        Navigator.of(context).pop(); // Cerrar el modal
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        Color(0xFF083434), // Color oscuro del botón
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Ok',
                        style: TextStyle(color: Colors.white),
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

  // Método para mostrar el modal de imágenes (como ya lo tienes)
  void _showImageDialog(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Color(0xFF38BCB4),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(imagePath), // Imagen seleccionada
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Lógica para eliminar
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF083434),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Eliminar',
                        style: TextStyle(color: Colors.white), // Letra blanca
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Lógica para examinar
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF083434),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Examinar',
                        style: TextStyle(color: Colors.white), // Letra blanca
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Cerrar el modal
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF083434),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Ok',
                        style: TextStyle(color: Colors.white), // Letra blanca
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
}

// Campo de texto personalizado (ya lo tienes)
class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final IconData icon;
  final bool obscureText;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.icon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, color: Colors.black)),
        const SizedBox(height: 8),
        TextField(
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: Icon(icon, color: Colors.teal),
            border: const OutlineInputBorder(
              borderRadius:
              BorderRadius.all(Radius.circular(15)), // Bordes redondeados
            ),
          ),
        ),
      ],
    );
  }
}

// Tabla de servicios (ya lo tienes)
class ServiceTable extends StatelessWidget {
  const ServiceTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.teal.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10), // Bordes redondeados
      ),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(2),
          1: FlexColumnWidth(1),
        },
        children: const [
          TableRow(children: [
            Text('Service Name', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Price', style: TextStyle(fontWeight: FontWeight.bold)),
          ]),
          TableRow(children: [
            Text('Baños'),
            Text('S/. 30'),
          ]),
          TableRow(children: [
            Text('Consultas Clínica'),
            Text('S/. 50'),
          ]),
          TableRow(children: [
            Text('Vacunas'),
            Text('S/. 80'),
          ]),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(home: VeterinaryConfig()));
}
