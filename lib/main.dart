import 'package:flutter/material.dart';
import 'UI/screens/LoginPage.dart';
import 'UI/screens/RegisterPage.dart';
import 'UI/screens/HomePage.dart';
import 'UI/screens/SearchPage.dart';
import 'UI/screens/CalendarPage.dart';
import 'UI/screens/ProfilePage.dart';
import 'UI/widgets/CustomNavBar.dart';
import 'UI/widgets/CustomAppBar.dart';
import 'UI/screens/map_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  final List<int> _navigationHistory = [];
  Map<String, dynamic> _currentUser = {};

  List<Widget> get _pages => [
    const HomePage(),
    const SearchPage(),
    MapView(),
    const ProfilePage(),
  ];

  void _onTabChange(int index) {
    setState(() {
      _navigationHistory.add(_selectedIndex);
      _selectedIndex = index;
    });
  }

  void _onBackButtonPressed() {
    if (_navigationHistory.isNotEmpty) {
      setState(() {
        _selectedIndex = _navigationHistory.removeLast();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(
          onLogin: (userData) {
            setState(() {
              _currentUser = userData;
              _selectedIndex = 0;
            });
            Navigator.pushNamed(context, '/home');
          },
        ),
        '/register': (context) => RegisterPage(
          onRegister: (userData) {
            setState(() {
              _currentUser = userData;
              _selectedIndex = 0;
            });
            Navigator.pushNamed(context, '/home');
          },
        ),
        '/home': (context) => Scaffold(
          appBar: CustomAppBar(onBackButtonPressed: _onBackButtonPressed),
          body: IndexedStack(
            index: _selectedIndex,
            children: _pages,
          ),
          bottomNavigationBar: CustomNavBar(
            selectedIndex: _selectedIndex,
            onTabChange: _onTabChange,
          ),
        ),
      },
    );
  }
}