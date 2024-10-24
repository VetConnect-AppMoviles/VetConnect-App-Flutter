import 'package:flutter/material.dart';
import 'package:app_vetconnect_flutter/screens/terminos_screen.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({Key? key}) : super(key: key);

  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  final List<Map<String, dynamic>> events = [
    {'title': 'Chequeo', 'day': 'Mon', 'time': '11:30 am', 'date': '02', 'type': 'chequeo'},
    {'title': 'Chequeo', 'day': 'Tues', 'time': '09:00 am', 'date': '03', 'type': 'chequeo'},
    {'title': 'Chequeo', 'day': 'Wed', 'time': '11:30 am', 'date': '04', 'type': 'chequeo'},
    {'title': 'Service', 'day': 'Wed', 'time': '14:00 pm', 'date': '04', 'type': 'service'},
    {'title': 'Service', 'day': 'Wed', 'time': '15:30 pm', 'date': '04', 'type': 'service'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Column(
        children: [
          _buildHeader(),
          _buildTabBar(),
          Expanded(
            child: _buildPageView(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: const Color(0xFF54D6B6),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 40,
            ),
            PopupMenuButton(
              onSelected: (value) {
                if (value == 'faq') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TerminosPage()),
                  );
                }
              },
              child: Image.asset(
                'assets/images/veterinary_logo.png',
                height: 40,
              ),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'profile',
                  child: Text('Configuración de perfil'),
                ),
                const PopupMenuItem(
                  value: 'transactions',
                  child: Text('Transacciones'),
                ),
                const PopupMenuItem(
                  value: 'faq',
                  child: Text('FAQ & Policy Terms'),
                ),
                const PopupMenuItem(
                  value: 'logout',
                  child: Text('Cerrar sesión'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: const Color(0xFF1B4332),
      child: Row(
        children: [
          Expanded(
            child: _buildTab('Chequeos', isSelected: true),
          ),
          Expanded(
            child: _buildTab('Baños'),
          ),
          Expanded(
            child: _buildTab('Vacunas', isShort: true),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String text, {bool isSelected = false, bool isShort = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF54D6B6) : Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: isSelected ? Colors.white : Colors.transparent,
            width: 2,
          ),
        ),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildPageView() {
    return PageView.builder(
      controller: _pageController,
      onPageChanged: (page) {
        setState(() {
          _currentPage = page;
        });
      },
      itemBuilder: (context, pageIndex) {
        final baseDay = (pageIndex * 3) % 6;
        return _buildTimelineView(pageIndex);
      },
    );
  }

  Widget _buildTimelineView(int pageIndex) {
    return Column(
      children: [
        _buildDayHeader(pageIndex),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: List.generate(13, (index) => _buildHourRow(index + 6, pageIndex)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDayHeader(int pageIndex) {
    final days = ['Mon', 'Tues', 'Wed', 'Thu', 'Fri', 'Sat'];
    final startDate = (pageIndex * 3) % 31 + 1;
    final dates = List.generate(3, (index) {
      return ((startDate + index - 1) % 31 + 1).toString().padLeft(2, '0');
    });

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          const SizedBox(width: 60),
          Expanded(
            child: Row(
              children: List.generate(3, (index) {
                return Expanded(
                  child: _buildDayCell('${days[(index % 6)]}\n${dates[index]}'),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayCell(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
    );
  }

  Widget _buildHourRow(int hour, int pageIndex) {
    return SizedBox(
      height: 60,
      child: Row(
        children: [
          SizedBox(
            width: 60,
            child: Text(
              '${hour.toString().padLeft(2, '0')}:00',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: List.generate(3, (index) {
                final day = ['Mon', 'Tues', 'Wed', 'Thu', 'Fri', 'Sat'][(index % 6)];
                return Expanded(
                  child: _buildTimeSlot(hour, day),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSlot(int hour, String day) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: _buildEventIfExists(hour, day),
    );
  }

  Widget _buildEventIfExists(int hour, String day) {
    final event = events.firstWhere(
          (e) => e['day'] == day && int.parse(e['time'].split(':')[0]) == hour,
      orElse: () => {},
    );

    if (event.isNotEmpty) {
      return _buildEventCard(
        event['title'],
        event['day'],
        event['time'],
      );
    }
    return Container();
  }

  Widget _buildEventCard(String title, String day, String time) {
    return GestureDetector(
      onTap: () => _showEventDetails(context),
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFFFD699),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Image.asset(
                  'assets/images/diagnostico.png',
                  height: 16,
                  width: 16,
                ),
              ],
            ),
            const SizedBox(height: 1),
            Text(
              time,
              style: const TextStyle(fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }

  void _showEventDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF30BAB2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/diagnostico.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Chequeo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Date: 2024-10-23',
                style: TextStyle(color: Colors.white),
              ),
              const Text(
                'Time: 11:30 AM',
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: const Size(double.infinity, 40),
                ),
                child: const Text('Cancelar cita'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(double.infinity, 40),
                ),
                child: const Text('Aceptar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
