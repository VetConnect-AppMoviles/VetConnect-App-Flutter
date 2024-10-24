import 'package:flutter/material.dart';

class AddServiceScreen extends StatelessWidget {
  const AddServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF54D6B6),
        title: const Text('Añadir Nuevo Servicio'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildDropdownService(),
            const SizedBox(height: 10),
            _buildTextField('Precio'),
            const SizedBox(height: 20),
            _buildButtonRow(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownService() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      items: const [
        DropdownMenuItem(value: 'Baños', child: Text('Baños')),
        DropdownMenuItem(value: 'Consultas Clínica', child: Text('Consultas Clínica')),
        DropdownMenuItem(value: 'Vacunas', child: Text('Vacunas')),
      ],
      onChanged: (value) {
        // Lógica para manejar cambios en el valor seleccionado
      },
      hint: const Text('Escoge un servicio'),
    );
  }

  Widget _buildTextField(String label) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildButtonRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildDialogButton(context, 'Cancelar', Colors.white),
        _buildDialogButton(context, 'Ok', Colors.white),
      ],
    );
  }

  Widget _buildDialogButton(BuildContext context, String text, Color textColor) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pop(); // Cierra el diálogo o la pantalla
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
