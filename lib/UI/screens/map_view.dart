import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(-12.0464, -77.0428); // Centro de Lima
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _fetchVetCenters();
  }

  Future<void> _fetchVetCenters() async {
    try {
      final response = await http.get(
        Uri.parse('https://vetconnect-backend-production.up.railway.app/api/vet-centers'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        for (var vet in data) {
          try {
            final LatLng coords = await _getCoordinatesFromAddress(vet['location']);
            setState(() {
              _markers.add(
                Marker(
                  markerId: MarkerId(vet['id'].toString()),
                  position: coords,
                  infoWindow: InfoWindow(
                    title: vet['name'],
                    snippet: vet['description'],
                  ),
                ),
              );
            });
          } catch (e) {
            print('Error al convertir la dirección: ${vet['location']} - $e');
          }
        }
      } else {
        print('Error al obtener los datos de las veterinarias: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<LatLng> _getCoordinatesFromAddress(String address) async {
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/geocode/json?address=${Uri.encodeComponent(address)}&key=AIzaSyDMj_FQTjJkO3JoO9G78Xg4TjDLYn6lrJ8',
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['results'].isNotEmpty) {
        final location = data['results'][0]['geometry']['location'];
        return LatLng(location['lat'], location['lng']);
      } else {
        throw Exception('No se encontraron resultados para la dirección: $address');
      }
    } else {
      throw Exception('Error en la solicitud de geocodificación: ${response.statusCode}');
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
        markers: _markers,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}