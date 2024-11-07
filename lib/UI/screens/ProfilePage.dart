import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final Map<String, dynamic> userData;

  const ProfilePage({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    String accountType = userData['roleId'] == 2 ? 'Dueño de mascota' : 'Veterinario';

    return Scaffold(
      backgroundColor: const Color(0xFFFEF1DE),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade200,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.teal.shade100,
                        backgroundImage: userData['photo'] != null ? NetworkImage(userData['photo']) : null,
                        child: userData['photo'] == null
                            ? const Icon(Icons.person, size: 50, color: Colors.teal)
                            : null,
                      ),
                      const SizedBox(height: 16),
                      _buildInfoRow('Nombre', userData['name'] ?? 'N/A', true),
                      const SizedBox(height: 8),
                      _buildInfoRow('Correo electrónico', userData['email'] ?? 'N/A', true),
                      const SizedBox(height: 8),
                      _buildInfoRow('Teléfono', userData['phone'] ?? 'N/A', true),
                      const SizedBox(height: 8),
                      _buildInfoRow('Tipo de cuenta', accountType, false),
                      if (userData['roleId'] == 1) ...[
                        const SizedBox(height: 8),
                        _buildInfoRow('Imagen de Perfil', userData['imageProfile'] ?? 'N/A', false),
                        const SizedBox(height: 8),
                        _buildInfoRow('Descripción', userData['description'] ?? 'N/A', false),
                        const SizedBox(height: 8),
                        _buildInfoRow('Ubicación', userData['location'] ?? 'N/A', false),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/');
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFFFFE0E0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    side: const BorderSide(color: Color(0xFFFF5757)),
                  ),
                  child: const Text(
                    'Cerrar sesión',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, bool showIcon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  value,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              if (showIcon)
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.teal),
                  iconSize: 20,
                  onPressed: () {
                    // Handle edit action
                  },
                ),
            ],
          ),
        ),
      ],
    );
  }
}