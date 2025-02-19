import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType? keyboardType;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.keyboardType,
  });


  //TODO: Implementar un controlador que capture los datos introducidos

  @override
  Widget build(BuildContext context) {
    return FieldDecoration(controller: controller, keyboardType: keyboardType, labelText: labelText);
  }
}

class FieldDecoration extends StatelessWidget {
  const FieldDecoration({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.labelText,
  });

  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return TextField(
    controller: controller,
    keyboardType: keyboardType,
    decoration: InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(
        color: Colors.black,   // Color del texto del label
        fontSize: 15,      
        fontWeight: FontWeight.w500,  // Tamaño del texto del label
      ),
      border: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.black,   // Color del borde
          width: 2.5,            // Grosor del borde
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.black,   
          width: 1.65,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.black,   
          width: 3.0,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
    ),
      );
  }
}