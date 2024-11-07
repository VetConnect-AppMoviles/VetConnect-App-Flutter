import 'package:flutter/material.dart';

import '../widgets/CustomAppBar.dart';

class TCPage extends StatefulWidget {
  const TCPage({Key? key}) : super(key: key);

  @override
  _TCPageState createState() => _TCPageState();
}

class _TCPageState extends State<TCPage> {
  final PageController _controller = PageController();
  final List<Map<String, String>> _questions = [
    {
      'title': 'Pregunta #1',
      'description':
      'Después de cada cita reservada a través de Vet Connect, los usuarios recibirán un enlace para dejar una reseña y calificar su experiencia con el centro veterinario y el profesional.',
    },
    {
      'title': 'Pregunta #2',
      'description':
      'El proceso de reserva de citas a través de Vet Connect es simple: los usuarios seleccionan el servicio deseado, el veterinario o centro veterinario, el día y la hora convenientes, y completan la reserva en pocos clics.',
    },
    {
      'title': 'Pregunta #3',
      'description':
      'La reprogramación de citas no está disponible a través de la plataforma de Vet Connect. Para cancelaciones o cambios, debes comunicarte directamente con el centro veterinario correspondiente.',
    },
    {
      'title': 'Pregunta #4',
      'description':
      'Sí, Vet Connect está disponible exclusivamente en la ciudad de Lima, conectando a los usuarios con centros veterinarios y profesionales locales.',
    },
    {
      'title': 'Pregunta #5',
      'description':
      'Vaya a la Pantalla de Inicio > Click en la Foto de Perfil > Configuración de mi Perfil y con eso ya estaría en la sección para editar la información de su perfil.',
    },
    {
      'title': 'Pregunta #6',
      'description':
      'Vet Connect ofrece una amplia variedad de servicios veterinarios, incluyendo consultas generales, procedimientos especializados, desparasitaciones, tratamientos de higiene y más, todos disponibles para reserva en línea.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header with back arrow and logo
          _buildHeader(),

          const SizedBox(height: 20),

          // Question cards with horizontal scrolling
          Container(
            height: 200,
            child: PageView.builder(
              controller: _controller,
              itemCount: _questions.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEE1B9),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/mail.png',
                              height: 30,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              _questions[index]['title']!,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _questions[index]['description']!,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          // Policy terms with a box that doesn't reach the bottom of the screen
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFBCFFEE),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Política de términos de Vet Connect',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Reservas y Citas:\n'
                            'a. Los usuarios pueden programar citas veterinarias a través de la plataforma en línea de Vet Connect.\n'
                            'b. Las reservas están sujetas a disponibilidad y pueden variar según la ubicación y el servicio requerido.\n'
                            'c. Se recomienda a los usuarios que reserven con anticipación para garantizar la disponibilidad deseada.\n\n'
                            'Responsabilidad del Usuario:\n'
                            'a. Los usuarios son responsables de proporcionar información precisa y actualizada sobre sus mascotas al programar citas.\n'
                            'b. Los usuarios deben cumplir con las políticas y procedimientos de las clínicas veterinarias asociadas durante las citas programadas.\n\n'
                            'Calificaciones y Reseñas:\n'
                            'a. Los usuarios pueden dejar comentarios y calificaciones sobre sus experiencias con los servicios veterinarios recibidos a través de Vet Connect.\n'
                            'b. Se anima a los usuarios a proporcionar comentarios constructivos y precisos para ayudar a otros miembros de la comunidad.\n\n'
                            'Privacidad y Seguridad:\n'
                            'a. Vet Connect se compromete a proteger la privacidad y seguridad de la información personal y médica de los usuarios y sus mascotas.\n'
                            'b. La información proporcionada por los usuarios se utilizará únicamente con el propósito de facilitar las citas veterinarias y mejorar la experiencia del usuario en la plataforma.\n\n'
                            'Modificaciones de los Términos:\n'
                            'a. Vet Connect se reserva el derecho de actualizar y modificar estos términos en cualquier momento sin previo aviso.\n'
                            'b. Se alienta a los usuarios a revisar periódicamente los términos para estar al tanto de cualquier cambio.',
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20), // Adding space at the bottom
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return CustomAppBar(
    onBackButtonPressed: () {
          Navigator.pop(context);
        },
        );
  }
}