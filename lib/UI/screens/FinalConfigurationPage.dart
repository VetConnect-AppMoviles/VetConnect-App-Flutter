import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/CustomTextField.dart';

class FinalConfigurationPage extends StatefulWidget {
  final int userId;
  final String phone;
  final int roleId;
  final String name;
  final String email;
  final String password;

  const FinalConfigurationPage({
    super.key,
    required this.userId,
    required this.phone,
    required this.roleId,
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  _FinalConfigurationPageState createState() => _FinalConfigurationPageState();
}

class _FinalConfigurationPageState extends State<FinalConfigurationPage> {
  final TextEditingController imageProfileController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController samplePhotosController = TextEditingController();
  final TextEditingController hoursController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController photoController = TextEditingController();
  List<Map<String, dynamic>> services = [];
  List<TextEditingController> serviceNameControllers = [];
  List<TextEditingController> servicePriceControllers = [];

  void _addService() {
    setState(() {
      services.add({'name': '', 'price': 0});
      serviceNameControllers.add(TextEditingController());
      servicePriceControllers.add(TextEditingController());
    });
  }

  void _removeService(int index) {
    setState(() {
      services.removeAt(index);
      serviceNameControllers[index].dispose();
      servicePriceControllers[index].dispose();
      serviceNameControllers.removeAt(index);
      servicePriceControllers.removeAt(index);
    });
  }

  Future<void> _submitVetCenterDetails() async {
    final List<Map<String, dynamic>> serviceDetails = [];
    for (int i = 0; i < services.length; i++) {
      serviceDetails.add({
        'name': serviceNameControllers[i].text,
        'price': int.parse(servicePriceControllers[i].text),
      });
    }

    final Map<String, dynamic> vetCenterDetails = {
      'id': 0,
      'userId': widget.userId,
      'name': widget.name,
      'email': widget.email,
      'password': widget.password,
      'imageProfile': imageProfileController.text,
      'description': descriptionController.text,
      'location': locationController.text,
      'services': serviceDetails,
      'samplePhotos': [samplePhotosController.text],
      'hours': [hoursController.text],
    };

    final response = await http.post(
      Uri.parse('https://resilient-contentment-production.up.railway.app/api/vet-centers'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(vetCenterDetails),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      print('Vet Center Details Submitted');
      Navigator.pushNamed(context, '/home');
    } else {
      print('Failed to submit vet center details');
    }
  }

  Future<void> _submitPetOwnerDetails() async {
    final Map<String, dynamic> petOwnerDetails = {
      'id': 0,
      'userId': widget.userId,
      'photo': photoController.text,
      'address': addressController.text,
      'phone': widget.phone,
    };

    final response = await http.post(
      Uri.parse('https://resilient-contentment-production.up.railway.app/api/pet-owners'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(petOwnerDetails),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      print('Pet Owner Details Submitted');
      Navigator.pushNamed(context, '/home');
    } else {
      print('Failed to submit pet owner details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF5CC6A9),
        flexibleSpace: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: 36,
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            color: const Color(0xFFFFF6E5),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset('assets/images/cat.png', height: 123),
                  ],
                ),
                const SizedBox(height: 20),
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
                  child: Column(
                    children: [
                      const Text(
                        'Final Configuration',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0E5252),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Complete your account setup',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: 10,
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (widget.roleId == 1) ...[
                        CustomTextField(
                          label: 'Image Profile URL',
                          controller: imageProfileController,
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          label: 'Description',
                          controller: descriptionController,
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          label: 'Location',
                          controller: locationController,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Services',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        ...services.asMap().entries.map((entry) {
                          int index = entry.key;
                          return Column(
                            children: [
                              CustomTextField(
                                label: 'Service Name',
                                controller: serviceNameControllers[index],
                              ),
                              const SizedBox(height: 8),
                              CustomTextField(
                                label: 'Service Price',
                                controller: servicePriceControllers[index],
                              ),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () => _removeService(index),
                                child: const Text('Remove Service'),
                              ),
                              const SizedBox(height: 16),
                            ],
                          );
                        }).toList(),
                        ElevatedButton(
                          onPressed: _addService,
                          child: const Text('Add Service'),
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          label: 'Sample Photos',
                          controller: samplePhotosController,
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          label: 'Hours',
                          controller: hoursController,
                        ),
                        const SizedBox(height: 32),
                        ElevatedButton(
                          onPressed: _submitVetCenterDetails,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF67DBBE),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 25),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Submit',
                            style: TextStyle(
                              color: Color(0xFF193D30),
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ] else if (widget.roleId == 2) ...[
                        CustomTextField(
                          label: 'Photo URL',
                          controller: photoController,
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          label: 'Address',
                          controller: addressController,
                        ),
                        const SizedBox(height: 32),
                        ElevatedButton(
                          onPressed: _submitPetOwnerDetails,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF67DBBE),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 25),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Submit',
                            style: TextStyle(
                              color: Color(0xFF193D30),
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ] else ...[
                        const Text(
                          'No additional configuration required for your role.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/pets.png', height: 200),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}