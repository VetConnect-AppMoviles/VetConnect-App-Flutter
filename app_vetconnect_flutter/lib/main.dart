import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/payment_screen.dart';
import 'screens/veterinary_config.dart';
import 'screens/home_veterinary_screen.dart';
import 'screens/home_veterinary_screen2.dart';
import 'screens/calendar_screen.dart';
import 'screens/terminos_screen.dart';
import 'screens/my_home_page.dart';
import 'screens/perfil_screen.dart';
import 'screens/config_perfil_empresa.dart';
import 'screens/add_service_screen.dart';
import 'screens/transaction_mobile.dart';

void main() {
  runApp(const VetConnectApp());
}

class VetConnectApp extends StatelessWidget {
  const VetConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VetConnect',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/payment': (context) => const PaymentScreen(),
        '/home': (context) => HomeVeterinaryScreen(),
        '/veterinary': (context) =>const  VeterinaryConfig(),
        '/home2': (context) =>  const HomeVeterinaryScreen2(),
        '/calendar': (context) => const CalendarView(),
        '/terminos': (context) => const TerminosPage(),
        '/myhome': (context) => const MyHomePage(),
        '/perfil': (context) => const PerfilScreen(),
        '/config': (context) =>  ConfigPerfilEmpresa(),
        '/addservice': (context) => const AddServiceScreen(),
        '/transaction': (context) => const TransactionMobileApp(),
      },
    );
  }
}
