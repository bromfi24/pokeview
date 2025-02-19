import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokeview/presentation/screens/widgets/buttons/poke_button.dart';
import 'package:pokeview/presentation/screens/widgets/intro/intro.dart';
import 'package:pokeview/presentation/screens/widgets/shared/custom_text_field.dart';



class SurveyScreen extends StatefulWidget {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

   SurveyScreen({
    super.key,
  });

  @override
  State<SurveyScreen> createState() => _SurveyUserState();
}

//TODO: Añadir comprobación mounted para evitar setState en un widget no montado

class _SurveyUserState extends State<SurveyScreen> {

  bool isCompleted = false;

  @override
  void initState() {
    super.initState();
    widget.nameController.addListener(validateForm);
    widget.emailController.addListener(validateForm);
    widget.dateController.addListener(validateForm);
  }

  @override
  void dispose() {
    widget.nameController.dispose();
    widget.emailController.dispose();
    widget.dateController.dispose();
    super.dispose();
  }

  void validateForm() {
    setState(() {
      isCompleted = widget.nameController.text.isNotEmpty &&
      widget.emailController.text.isNotEmpty &&
      widget.dateController.text.isNotEmpty;
    });
  }

  void clearFields() {
    setState(() {
      widget.nameController.clear();
      widget.emailController.clear();
      widget.dateController.clear();
      isCompleted = false;
    });
  }

  //TODO: Implementar validación de campos
  // void showValidationError() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text("Error"),
  //         content: const Text("Por favor, completa todos los campos antes de continuar."),
  //         actions: [
  //           TextButton(
  //             onPressed: () => context.pop(),
  //             child: const Text("OK"),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(35.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                const Text(
                  'PokeView',
                    style: TextStyle(
                    fontSize: 85,  
                    fontFamily: 'PokemonFont',  
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 60),
                CustomTextField(
                  controller: widget.nameController,
                  labelText: 'Nombre y Apellidos',
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: widget.emailController,
                  labelText: 'Email de contacto',
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: widget.dateController,
                  labelText: 'Fecha de visualización',
                  keyboardType: TextInputType.datetime,
                ),
                const SizedBox(height: 40),
                isCompleted ? 
                Column(
                  children: [
                    PokeButton(
                      onTap: () {
                        clearFields();
                        context.push('/list');
                      },
                    ),
                    const Text(
                      'Pulsa en la pokeball para continuar',
                      textAlign: TextAlign.center,
                        style: TextStyle(
                        fontSize: 30,  
                        fontFamily: 'PokemonFont',  
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ) 
                : const IntroWidget(),
              ],
            ),
          ),
        ),
    );
  }
}
