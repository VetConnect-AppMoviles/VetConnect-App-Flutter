import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'add_service_screen.dart'; // Asegúrate de que este archivo exista.

void main() {
  runApp(const ConfigPerfilEmpresaApp());
}

class ConfigPerfilEmpresaApp extends StatelessWidget {
  const ConfigPerfilEmpresaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<Map<String, dynamic>> fetchUserData() async {
    const url = 'https://my-json-server.typicode.com/RodrLH/vetconnect-jsonserver/db';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final user = (data['users'] as List).firstWhere((u) => u['id'] == 1);
      return user;
    } else {
      throw Exception('Error al cargar los datos del usuario.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEF1DE),
      body: SafeArea(
        child: FutureBuilder<Map<String, dynamic>>(
          future: fetchUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('No se encontraron datos.'));
            } else {
              final user = snapshot.data!;
              return _buildContent(context, user);
            }
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, Map<String, dynamic> user) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            _buildProfileSection(user),
            const SizedBox(height: 20),
            _buildServiceTable(),
            const SizedBox(height: 20),
            _buildImageGallery(),
            const SizedBox(height: 20),
            _buildButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 80,
      color: const Color(0xFF54D6B6),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/logo.png', width: 50, height: 50),
          const SizedBox(width: 10),
          const Text(
            'VET CONNECT',
            style: TextStyle(
              color: Colors.orange,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection(Map<String, dynamic> user) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFC878),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage('assets/profile.png'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF90FBD4),
            ),
            child: const Text('Upload'),
          ),
          const SizedBox(height: 10),
          _buildTextField('Address', initialValue: user['email']),
          _buildTextField('Password', obscureText: true, initialValue: user['password']),
          _buildTextField('Mobile Number', initialValue: user['phone'].toString()),
          _buildTextField('RUC', initialValue: user['ruc'].toString()),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, {String? initialValue, bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        obscureText: obscureText,
        controller: TextEditingController(text: initialValue),
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: const Icon(Icons.edit, color: Color(0xFF90FBD4)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget _buildServiceTable() {
    return DataTable(
      headingRowColor: MaterialStateProperty.resolveWith((states) => const Color(0xFF30B9B1)),
      columns: const [
        DataColumn(label: Text('Service Name')),
        DataColumn(label: Text('Price')),
      ],
      rows: const [
        DataRow(cells: [DataCell(Text('Baños')), DataCell(Text('S/. 30'))]),
        DataRow(cells: [DataCell(Text('Consultas Clínica')), DataCell(Text('S/. 50'))]),
        DataRow(cells: [DataCell(Text('Vacunas')), DataCell(Text('S/. 80'))]),
      ],
    );
  }

  Widget _buildImageGallery() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildImageCard('assets/vet_config_2.png'),
        const SizedBox(width: 10),
        _buildImageCard('assets/vet_config_3.png'),
        const SizedBox(width: 10),
        _buildImageCard('assets/vet_config_4.png'),
      ],
    );
  }

  Widget _buildImageCard(String imagePath) {
    return Container(
      width: 87,
      height: 87,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddServiceScreen()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF90FBD4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: const Text(
            'AÑADIR SERVICIO',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        _buildActionButton('ACEPTAR Y GUARDAR'),
      ],
    );
  }

  Widget _buildActionButton(String text) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF90FBD4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
