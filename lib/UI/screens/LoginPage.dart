import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/CustomTextField.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final Function(Map<String, dynamic>) onLogin;

  LoginScreen({super.key, required this.onLogin});

  Future<void> _loginUser(BuildContext context) async {
    final String email = emailController.text;
    final String password = passwordController.text;

    final response = await http.get(
      Uri.parse('http://vetconnect-backend-production.up.railway.app/api/users'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> users = json.decode(response.body);
      final user = users.firstWhere(
            (user) => user['email'] == email && user['password'] == password,
        orElse: () => null,
      );

      if (user != null) {
        print('Login Successful: ${user['name']}');
        onLogin(user);
        Navigator.pushNamed(context, '/home');
      } else {
        print('Invalid email or password');
      }
    } else {
      print('Failed to fetch users');
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
                    Image.asset('assets/images/pets2.png', height: 170),
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
                        'Iniciar Sesión',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0E5252),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Ingresa tus datos para ingresar a VetConnect',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: 10,
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                          label: 'Email', controller: emailController),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: 'Password',
                        controller: passwordController,
                        obscureText: true,
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: () => _loginUser(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF67DBBE),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 25),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Ingresar',
                          style: TextStyle(
                            color: Color(0xFF193D30),
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('¿No tienes una cuenta? '),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/register');
                            },
                            child: const Text(
                              'Registrarse',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Color(0xFF193D30),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    Image.asset('assets/images/dog.png',
                        height: 230),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}