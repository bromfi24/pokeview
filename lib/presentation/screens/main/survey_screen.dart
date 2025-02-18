import 'package:flutter/material.dart';
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
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/main-screen');
                },
                child: const Text('Go to Pokemon List'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
