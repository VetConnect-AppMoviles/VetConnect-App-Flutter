import 'package:app_vetconnect/UI/screens/T&CPage.dart';
import 'package:app_vetconnect/UI/widgets/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool paymentConfirmed = false;
  bool termsAccepted = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.addListener(_validateForm);
    cardNumberController.addListener(_validateForm);
    expDateController.addListener(_validateForm);
    cvvController.addListener(_validateForm);
  }

  void _validateForm() {
    setState(() {});
  }

  bool _isFormValid() {
    return nameController.text.isNotEmpty &&
        cardNumberController.text.isNotEmpty &&
        expDateController.text.isNotEmpty &&
        cvvController.text.isNotEmpty &&
        termsAccepted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onBackButtonPressed: () {
          Navigator.pop(context);
        },
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
                if (!paymentConfirmed)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF1FEFF),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: const Color(0xFF54D6B6),
                                        width: 2), // Borde circular
                                  ),
                                  child: const Icon(Icons.person,
                                      color: Colors.orange),
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  'Details',
                                  style: TextStyle(
                                    color: Color(0xFF0E5252),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF1FEFF),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: const Color(0xFF54D6B6),
                                        width: 2),
                                  ),
                                  child: const Icon(Icons.credit_card,
                                      color: Colors.orange),
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  'Payment',
                                  style: TextStyle(
                                    color: Color(0xFF0E5252),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: const Color(0xFFA1AEBE),
                                        width: 2),
                                  ),
                                  child: const Icon(Icons.favorite,
                                      color: Colors.black),
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  'Thank You',
                                  style: TextStyle(
                                    color: Color(0xFF0E5252),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Formulario de pago en un contenedor
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  const Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start, // Alinea el texto a la izquierda
                                    children: [
                                      Text(
                                        'Payment Method',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'Please enter your payment details',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 8),
                                  Image.asset('assets/images/methods.png',
                                      height: 35),
                                ],
                              ),
                              const SizedBox(height: 20),
                              // Campos del formulario
                              _buildTextField(
                                'NAME ON CARD',
                                nameController,
                                borderColor: const Color(
                                    0xFFFF9900), // Color del borde naranja
                              ),
                              const SizedBox(height: 16),
                              _buildTextField(
                                'CARD NUMBER',
                                cardNumberController,
                                borderColor: const Color(0xFF54D6B6),
                                validator: CreditCardValidator.validate,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(19),
                                  TextInputFormatter.withFunction((oldValue, newValue) {
                                    if (newValue.text.length > oldValue.text.length) {
                                      if (newValue.text.length == 4 ||
                                          newValue.text.length == 9 ||
                                          newValue.text.length == 14) {
                                        return TextEditingValue(
                                          text: '${newValue.text} ',
                                          selection: TextSelection.collapsed(offset: newValue.selection.end + 1),
                                        );
                                      }
                                    }
                                    return newValue;
                                  }),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildTextField(
                                      'EXP DATE (MM/YY)',
                                      expDateController,
                                      borderColor: const Color(0xFFFF9900),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(5),
                                        ExpirationDateFormatter(),
                                      ],
                                      validator: (value) => ExpirationDateValidator.validate(value),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: _buildTextField(
                                      'CVV',
                                      cvvController,
                                      obscureText: true,
                                      borderColor: const Color(
                                          0xFF54D6B6),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(3),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              // Checkbox de términos y condiciones
                              Row(
                                children: [
                                  Checkbox(
                                    value: termsAccepted,
                                    onChanged: (value) {
                                      setState(() {
                                        termsAccepted = value!;
                                      });
                                    },
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const TCPage(),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        'I have read and accepted the Terms and Conditions, also given consent to use my personal info.',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              // Botón de pagar
                              Center(
                                child: ElevatedButton(
                                  onPressed: _isFormValid()
                                      ? () {
                                    setState(() {
                                      paymentConfirmed = true;
                                    });
                                  }
                                      : null, // Deshabilita el botón si no se han aceptado los términos
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: _isFormValid()
                                        ? const Color(0xFF67DBBE)
                                        : Colors.grey, // Color del botón
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 25),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text(
                                    'Pagar',
                                    style: TextStyle(
                                      color: Color(0xFF193D30),
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                else
                // Pantalla de confirmación de reserva
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF1FEFF),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: const Color(0xFF54D6B6),
                                        width: 2), // Borde circular
                                  ),
                                  child: const Icon(Icons.person,
                                      color: Colors.orange),
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  'Details',
                                  style: TextStyle(
                                    color: Color(0xFF0E5252),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF1FEFF),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: const Color(0xFF54D6B6),
                                        width: 2),
                                  ),
                                  child: const Icon(Icons.credit_card,
                                      color: Colors.orange),
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  'Payment',
                                  style: TextStyle(
                                    color: Color(0xFF0E5252),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF1FEFF),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: const Color(0xFF54D6B6),
                                        width: 2),
                                  ),
                                  child: const Icon(Icons.favorite,
                                      color: Colors.orange),
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  'Thank You',
                                  style: TextStyle(
                                    color: Color(0xFF0E5252),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Contenedor de confirmación de reserva
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color:
                            Colors.white, // Fondo blanco para el contenedor
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Confirmación',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                        height: 8), // Espacio entre los textos
                                    Text(
                                      'de la Reserva',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              Container(
                                padding: const EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE8FFF9),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Column(
                                  children: [
                                    Icon(
                                      Icons.check_circle_outline,
                                      size: 80,
                                      color: Colors.green,
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      'Gracias por reservar!',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF067373)),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Hemos enviado una copia de la confirmación a su correo.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/home');
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFFFF3E0),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 25),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: const BorderSide(
                                        color: Color(0xFFFFBB57),
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    'Volver al Inicio',
                                    style: TextStyle(
                                      color: Color(0xFF664617),
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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

  Widget _buildTextField(
      String label,
      TextEditingController controller, {
        bool obscureText = false,
        required Color borderColor,
        List<TextInputFormatter>? inputFormatters,
        String? Function(String?)? validator,
      }) {
    final focusNode = FocusNode();
    Color hintColor = const Color(0xFF949393);

    return StatefulBuilder(
      builder: (context, setState) {
        // Escucha cambios en el enfoque del campo
        focusNode.addListener(() {
          setState(() {});
        });

        return TextField(
          controller: controller,
          obscureText: obscureText,
          focusNode: focusNode,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
              color: focusNode.hasFocus ? borderColor : hintColor,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: borderColor,
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: borderColor,
                width: 2,
              ),
            ),
            errorText:  validator != null ? validator(controller.text) : null,
          ),
          onTap: () {
            focusNode.requestFocus();
          },
        );
      },
    );
  }
}

class ExpirationDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    String newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), ''); // Solo números

    if (newText.length > 4) {
      newText = newText.substring(0, 4);
    }

    if (newText.length >= 3) {
      newText = '${newText.substring(0, 2)}/${newText.substring(2)}';
    }

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

class ExpirationDateValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'La fecha es requerida';
    }

    RegExp exp = RegExp(r"^(0[1-9]|1[0-2])\/([0-9]{2})$"); // Exactamente 2 dígitos para MM y YY
    if (!exp.hasMatch(value)) {
      return 'Fecha no válida (MM/YY)';
    }

    final parts = value.split('/');
    final month = int.parse(parts[0]);
    final year = int.parse(parts[1]);

    final now = DateTime.now();
    final currentYear = int.parse(now.year.toString().substring(2, 4));
    final currentMonth = now.month;

    if (year < currentYear || (year == currentYear && month < currentMonth)) {
      return 'La tarjeta ha expirado';
    }

    return null;
  }
}

class CreditCardValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'El número de tarjeta es requerido';
    }

    value = value.replaceAll(RegExp(r'\s+|-'), '');

    if (value.length < 13 || value.length > 19) {
      return 'Número de tarjeta no válido';
    }

    int sum = 0;
    bool alternate = false;
    for (int i = value.length - 1; i >= 0; i--) {
      int n = int.parse(value[i]);
      if (alternate) {
        n *= 2;
        if (n > 9) {
          n -= 9;
        }
      }
      sum += n;
      alternate = !alternate;
    }

    if (sum % 10 != 0) {
      return 'Número de tarjeta no válido';
    }

    return null;
  }
}





