import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

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
                  height: 60,
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          // Fondo principal
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
                // Formulario de registro
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
                      // Botones de Cliente/Empresa
                      const SizedBox(height: 16),
                      // Campos del formulario
                      CustomTextField(
                          label: 'Email', controller: emailController),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: 'Password',
                        controller: passwordController,
                        obscureText: true,
                      ),
                      const SizedBox(height: 32),
                      // Botón de Crear cuenta
                      ElevatedButton(
                        onPressed: () {
                          // Lógica de registro
                          Navigator.pushNamed(context, '/home');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFF67DBBE), // Verde claro
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
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Imagen inferior con texto
                Column(
                  children: [
                    Image.asset('assets/images/dog.png',
                        height: 230), // Imagen inferior
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
