import 'package:flutter/material.dart';
import '../widgets/CustomAppBar.dart';

class TCPage extends StatefulWidget {
  const TCPage({super.key});

  @override
  _TCPageState createState() => _TCPageState();
}

class _TCPageState extends State<TCPage> {
  final PageController _controller = PageController();
  final List<Map<String, String>> _questions = [
    {
      'title': '¿Cómo puedo registrar mi clínica veterinaria en VetConnect?',
      'description':
          'Para registrar tu clínica veterinaria, debes completar el formulario de configuración final, proporcionando detalles como el nombre, correo electrónico, contraseña, teléfono, y otros datos relevantes de la clínica. ¡Todo desde la comodidad de tu dispositivo móvil!',
    },
    {
      'title':
          '¿Qué información necesito para registrar mi clínica veterinaria?',
      'description':
          'Para registrar tu clínica veterinaria en VetConnect, necesitas proporcionar información como el nombre de la clínica, correo electrónico, contraseña, teléfono, descripción, ubicación, servicios ofrecidos, fotos de muestra y horarios de atención.',
    },
    {
      'title': '¿Cómo puedo registrar un dueño de mascota en VetConnect?',
      'description':
          'Para registrar un dueño de mascota, debes completar el formulario de configuración final, proporcionando detalles como el nombre, correo electrónico, contraseña, teléfono, dirección y una foto de perfil. ¡Todo desde la comodidad de tu dispositivo móvil!',
    },
    {
      'title': '¿Cómo puedo eliminar una clínica veterinaria registrada?',
      'description':
          'Actualmente, para poder eliminar clínicas veterinarias desde el apartado de perfil. Para realizar cambios, te recomendamos comunicarte con el soporte técnico de VetConnect. Esto borrará tu cuenta.',
    },
    {
      'title': '¿Cómo actualizo mi perfil en VetConnect?',
      'description':
          'Para actualizar tu perfil, solo tienes que ir a la pantalla de inicio, hacer clic en tu foto de perfil y luego seleccionar la opción "Configuración de mi Perfil". ¡Así podrás modificar tu información fácilmente!',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header con logo y botón de retroceso
            _buildHeader(),

            const SizedBox(height: 20),

            // Tarjetas de preguntas con desplazamiento horizontal
            SizedBox(
              height: screenHeight * 0.3,
              child: PageView.builder(
                controller: _controller,
                itemCount: _questions.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                    child: Container(
                      padding: EdgeInsets.all(screenWidth * 0.04),
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
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    _questions[index]['title']!,
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.05,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              _questions[index]['description']!,
                              style: TextStyle(
                                fontSize: screenWidth * 0.04,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // Términos y condiciones
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Container(
                padding: EdgeInsets.all(screenWidth * 0.04),
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
                child: const SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Términos y Condiciones de Vet Connect',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Reservas y Citas:\n'
                        'a. Las citas están sujetas a disponibilidad y deben reservarse con anticipación para garantizar el horario deseado.\n'
                        'b. Es responsabilidad del usuario confirmar la disponibilidad del centro veterinario seleccionado antes de la cita.\n\n'
                        'Responsabilidad del Usuario:\n'
                        'a. Los usuarios deben proporcionar información completa y actualizada sobre sus mascotas.\n'
                        'b. Vet Connect no se hace responsable de cancelaciones por información incorrecta proporcionada por el usuario.\n\n'
                        'Reseñas y Calificaciones:\n'
                        'a. Las reseñas deben ser honestas y reflejar la experiencia real con el servicio recibido.\n'
                        'b. Vet Connect se reserva el derecho de moderar comentarios ofensivos o que no cumplan con nuestras políticas.\n\n'
                        'Privacidad y Seguridad:\n'
                        'a. La información de los usuarios será utilizada exclusivamente para gestionar reservas y mejorar la experiencia en la plataforma.\n'
                        'b. Vet Connect sigue estándares de seguridad para proteger la información sensible.\n\n'
                        'Modificaciones de los Términos:\n'
                        'a. Vet Connect puede actualizar estos términos en cualquier momento, notificando previamente a los usuarios.\n'
                        'b. El uso continuado de la plataforma implica la aceptación de los términos actualizados.',
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20), // Espacio inferior
          ],
        ),
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
