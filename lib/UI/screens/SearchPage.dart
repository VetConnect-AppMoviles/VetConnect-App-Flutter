// lib/UI/screens/SearchPage.dart

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'VetInfoPage.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _veterinaryClinics = [];
  List<Map<String, dynamic>> _filteredClinics = [];

  @override
  void initState() {
    super.initState();
    _fetchVeterinaryClinics();
    _searchController.addListener(_filterClinics);
  }

  Future<void> _fetchVeterinaryClinics() async {
    final response = await http.get(
      Uri.parse('http://vetconnect-backend-production.up.railway.app/api/vet-centers'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> clinics = json.decode(response.body);
      setState(() {
        _veterinaryClinics = clinics.cast<Map<String, dynamic>>();
        _filteredClinics = _veterinaryClinics;
      });
    } else {
      throw Exception('Failed to load veterinary clinics');
    }
  }

  void _filterClinics() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredClinics = _veterinaryClinics.where((clinic) {
        return clinic['name'].toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterClinics);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search by name',
                labelStyle: TextStyle(color: Color(0xFFFF9900)),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFFF9900)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFFF9900)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFFF9900)),
                ),
              ),
              style: const TextStyle(color: Color(0xFFFF9900)),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredClinics.length,
                itemBuilder: (context, index) {
                  final clinic = _filteredClinics[index];
                  return SizedBox(
                    width: double.infinity,
                    child: Card(
                      color: const Color(0xFFFFF2E0),
                      child: ListTile(
                        title: Text(clinic['name'],
                          style: const TextStyle(
                            fontSize: 18,
                            color: Color(0xFF003333),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(clinic['location']),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VetInfoPage(vetCenter: clinic),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}