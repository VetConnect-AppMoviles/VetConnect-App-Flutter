import 'package:flutter/material.dart';

void main() {
  runApp(const TransactionMobileApp());
}

class TransactionMobileApp extends StatelessWidget {
  const TransactionMobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFFFEF1DE),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              const Text(
                'Transactions',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'League Spartan',
                ),
              ),
              const SizedBox(height: 20),
              _buildScrollableTable(),
            ],
          ),
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
          Image.asset(
            'assets/logo.png', // Ruta del logo desde tu proyecto
            width: 50,
            height: 50,
          ),
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

  Widget _buildScrollableTable() {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 20,
          headingRowColor:
          MaterialStateColor.resolveWith((states) => const Color(0xFF30B9B1)),
          columns: const [
            DataColumn(label: Text('Email')),
            DataColumn(label: Text('Service')),
            DataColumn(label: Text('Date')),
            DataColumn(label: Text('Price')),
            DataColumn(label: Text('Commission')),
            DataColumn(label: Text('Net Price')),
          ],
          rows: List<DataRow>.generate(
            8,
                (index) => const DataRow(
              cells: [
                DataCell(Text('example')),
                DataCell(Text('Service')),
                DataCell(Text('DD/MM/YY')),
                DataCell(Text('S/.')),
                DataCell(Text('- S/.')),
                DataCell(Text('S/.')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
