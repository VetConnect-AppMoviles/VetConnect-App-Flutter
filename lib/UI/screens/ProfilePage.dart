import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  final Map<String, dynamic> userData;

  const ProfilePage({super.key, required this.userData});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Map<String, dynamic> _userData;

  @override
  void initState() {
    super.initState();
    _userData = Map.from(widget.userData);
  }

  @override
  Widget build(BuildContext context) {
    String accountType =
        _userData['roleId'] == 2 ? 'Dueño de mascota' : 'Veterinario';

    return Scaffold(
      backgroundColor: const Color(0xFFFEF1DE),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
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
                            backgroundImage: _userData['photo'] != null
                                ? NetworkImage(_userData['photo'])
                                : null,
                            child: _userData['photo'] == null
                                ? const Icon(Icons.person,
                                    size: 50, color: Colors.teal)
                                : null,
                          ),
                          const SizedBox(height: 16),
                          _buildInfoRow('name', _userData['name'] ?? 'N/A'),
                          const SizedBox(height: 8),
                          _buildInfoRow('email', _userData['email'] ?? 'N/A'),
                          const SizedBox(height: 8),
                          _buildInfoRow('phone', _userData['phone'] ?? 'N/A'),
                          const SizedBox(height: 8),
                          _buildInfoRow('accountType', accountType)
                        ],
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteAccount(context),
                      ),
                    ),
                  ],
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

  Widget _buildInfoRow(String label, String value) {
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
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _deleteAccount(BuildContext context) async {
    final bool confirm = await _showConfirmationDialog(context);
    if (!confirm) return;

    String url;
    if (_userData['roleId'] == 2) {
      url =
          'https://vetconnect-backend-production.up.railway.app/api/pet-owners/${_userData['id']}';
    } else if (_userData['roleId'] == 1) {
      url =
          'https://vetconnect-backend-production.up.railway.app/api/vet-centers/${_userData['id']}';
    } else {
      url =
          'https://vetconnect-backend-production.up.railway.app/api/users/${_userData['id']}';
    }

    try {
      final response = await http.delete(Uri.parse(url));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print('Account Deleted');
        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
      } else {
        print('Failed to delete account: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Failed to delete account: ${response.statusCode}')),
        );
      }
    } catch (e) {
      print('Error deleting account: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting account: $e')),
      );
    }
  }

  Future<bool> _showConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Confirm Deletion'),
            content: const Text(
                'Are you sure you want to delete your account? This action cannot be undone.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Delete'),
              ),
            ],
          ),
        ) ??
        false;
  }
}
