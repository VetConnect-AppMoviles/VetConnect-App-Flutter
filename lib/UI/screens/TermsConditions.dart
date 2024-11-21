import 'package:flutter/material.dart';
import '../widgets/CustomAppBar.dart';

class TermsConditions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with logo and back button
            _buildHeader(context),

            const SizedBox(height: 20),

            // Terms and Conditions
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

            const SizedBox(height: 20), // Bottom space
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return CustomAppBar(
      onBackButtonPressed: () {
        Navigator.pop(context);
      },
    );
  }
}