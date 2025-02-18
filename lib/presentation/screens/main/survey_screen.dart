import 'package:flutter/material.dart';
import 'package:pokeview/presentation/screens/main/poke_button.dart';
import 'package:pokeview/presentation/screens/widgets/shared/custom_text_field.dart';


class SurveyScreen extends StatelessWidget {
  const SurveyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController dateController = TextEditingController();

    return Scaffold(
      body: Padding(
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
              controller: nameController,
              labelText: 'Name and Surname',
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: emailController,
              labelText: 'Contact Email',
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: dateController,
              labelText: 'Test Date',
              keyboardType: TextInputType.datetime,
            ),
            const SizedBox(height: 40),
            PokeButton(),
            const SizedBox(height: 20),
            const Text(
                'Pulsa la pokeball para continuar',
                style: TextStyle(
                  fontSize: 25,  // Ajusta el tamaño del texto
                  color: Colors.black,
                  fontFamily: 'PokemonFont',
                  fontWeight: FontWeight.bold,
                ),
            ),
          ],
        ),
      ),
    );
  }
}
