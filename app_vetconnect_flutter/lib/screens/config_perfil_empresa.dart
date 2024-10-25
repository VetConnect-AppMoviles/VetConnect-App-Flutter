import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../widgets/custom_text_field.dart';

class ConfigPerfilEmpresa extends StatefulWidget {
  @override
  _ConfigPerfilEmpresaState createState() => _ConfigPerfilEmpresaState();
}

class _ConfigPerfilEmpresaState extends State<ConfigPerfilEmpresa> {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController serviceController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  bool isAddServiceVisible = false;
  late Future<Map<String, dynamic>> _userData;

  @override
  void initState() {
    super.initState();
    _userData = fetchUserData();
  }

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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF5CC6A9),
        title: Image.asset('assets/images/logo.png', height: 60),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Main background
          Container(
            color: const Color(0xFFFFF6E5),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Form container
                Container(
                  padding: const EdgeInsets.all(16.0),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6BE69),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: FutureBuilder<Map<String, dynamic>>(
                    future: _userData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData) {
                        return const Center(child: Text('No se encontraron datos.'));
                      } else {
                        final user = snapshot.data!;
                        addressController.text = user['email'];
                        passwordController.text = user['password'];
                        mobileController.text = user['phone'].toString();
                        return _buildContent(context);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          // Add Service popup
          if (isAddServiceVisible)
            Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFF30BAB2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'AÑADIR NUEVO SERVICIO',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF000000),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Servicio',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF000000),
                      ),
                    ),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: 'Escoge un servicio'),
                      items: <String>['Baños', 'Consultas Clínica', 'Vacunas']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          serviceController.text = newValue!;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Precio',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF000000),
                      ),
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      label: 'S/. ',
                      controller: priceController,
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isAddServiceVisible = false;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: const Color(0xFFFFFFFF), backgroundColor: Color(0xFF003333),
                          ),
                          child: const Text(
                            'Cancelar',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            // Handle new service logic here
                            setState(() {
                              isAddServiceVisible = false;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: const Color(0xFFFFFFFF), backgroundColor: Color(0xFF003333),
                          ),
                          child: const Text(
                            'Ok',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      children: [
        const CircleAvatar(
          radius: 60,
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage('assets/images/veterinary_logo.png'),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            // Handle upload logic
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF5CC6A9),
          ),
          child: const Text('Upload'),
        ),
        const SizedBox(height: 20),
        CustomTextField(
          label: 'Address',
          controller: addressController,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          label: 'Password',
          controller: passwordController,
          obscureText: true,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          label: 'Mobile Number',
          controller: mobileController,
        ),
        const SizedBox(height: 20),
        // Service table
        const Text(
          'Services',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0E5252),
          ),
        ),
        const SizedBox(height: 20),
        Table(
          border: TableBorder.symmetric(
            inside: BorderSide(color: Colors.black),
            outside: BorderSide(color: Colors.teal, width: 2),
          ),
          columnWidths: const {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(1),
          },
          children: const [
            TableRow(
              decoration: BoxDecoration(color: Color(0xFF30BAB2)),
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Service Name', textAlign: TextAlign.center),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Price', textAlign: TextAlign.center),
                ),
              ],
            ),
            TableRow(
              decoration: BoxDecoration(color: Color(0xFFBDECE1)),
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Baños', textAlign: TextAlign.center),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('S/. 30', textAlign: TextAlign.center),
                ),
              ],
            ),
            TableRow(
              decoration: BoxDecoration(color: Color(0xFFBDECE1)),
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Consultas Clínica', textAlign: TextAlign.center),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('S/. 50', textAlign: TextAlign.center),
                ),
              ],
            ),
            TableRow(
              decoration: BoxDecoration(color: Color(0xFFBDECE1)),
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Vacunas', textAlign: TextAlign.center),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('S/. 80', textAlign: TextAlign.center),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 30),

        // Images Section
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset('assets/images/vet_config_1.png', height: 100, width: 100),
            Image.asset('assets/images/vet_config_2.png', height: 100, width: 100),
            Image.asset('assets/images/vet_config_3.png', height: 100, width: 100),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isAddServiceVisible = true;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5CC6A9),
                padding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 25),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Añadir Servicio'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/calendar');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5CC6A9),
                padding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 25),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Aceptar y Guardar'),
            ),
          ],
        ),
      ],
    );
  }
}
