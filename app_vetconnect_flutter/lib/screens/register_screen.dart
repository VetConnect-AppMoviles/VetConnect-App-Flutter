import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dniController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isClientSelected = true;

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
                    Image.asset('assets/images/cat.png', height: 123),
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
                        'Registrarse',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0E5252),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Ingresa tus datos personales para crear tu cuenta en VetConnect',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: 10,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Botones de Cliente/Empresa
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isClientSelected = true;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isClientSelected
                                    ? const Color(0xFFA6FFE8)
                                    : const Color(0xFF1E4E3C),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                'Cliente',
                                style: TextStyle(
                                    color: isClientSelected
                                        ? const Color(0xFF000000)
                                        : Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isClientSelected = false;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isClientSelected
                                    ? const Color(0xFF1E4E3C)
                                    : const Color(0xFFA6FFE8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                'Empresa',
                                style: TextStyle(
                                    color: isClientSelected
                                        ? Colors.white
                                        : const Color(0xFF000000)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Campos del formulario
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                                label: 'Name', controller: nameController),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: CustomTextField(
                                label: 'DNI', controller: dniController),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                          label: 'Email', controller: emailController),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: 'Password',
                        controller: passwordController,
                        obscureText: true,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: 'Confirm Password',
                        controller: confirmPasswordController,
                        obscureText: true,
                      ),
                      const SizedBox(height: 32),
                      // Botón de Crear cuenta
                      ElevatedButton(
                        onPressed: () {
                          // Lógica de registro
                          print('User Registered: ${nameController.text}');
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
                          'Crear cuenta',
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
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20), // Padding a la izquierda
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/pets.png',
                          height: 200), // Imagen a la izquierda
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
