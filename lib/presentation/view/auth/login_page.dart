import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokeview/presentation/common/resources/responsive.dart';
import 'package:pokeview/presentation/common/widget/buttons/poke_button.dart';
import 'package:pokeview/presentation/navigation/navigation_routes.dart';
import 'package:pokeview/presentation/view/auth/intro.dart';
import 'package:pokeview/presentation/common/widget/input/generic_field.dart';



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

class _SurveyUserState extends State<SurveyScreen> {

  bool isCompleted = false;
  bool isMounted = true;

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
    widget.nameController.removeListener(validateForm);
    widget.emailController.removeListener(validateForm);
    widget.dateController.removeListener(validateForm);
    isMounted = false;
    super.dispose();
  }

  void validateForm() {
    if( !isMounted ) return;
    setState(() {
      isCompleted = widget.nameController.text.isNotEmpty &&
      widget.emailController.text.isNotEmpty &&
      widget.dateController.text.isNotEmpty;
    });
  }

  void clearFields() async {
    if( !isMounted ) return;
    setState(() {
      widget.nameController.clear();
      widget.emailController.clear();
      widget.dateController.clear();
      isCompleted = false;
      FocusScope.of(context).unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(responsive.widthPercent(5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: responsive.heightPercent(2)),
              Text(
                'PokeView',
                style: TextStyle(
                  fontSize: responsive.widthPercent(15), // Ajusta el tamaño de fuente
                  fontFamily: 'PokemonFont',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: responsive.heightPercent(5)),
              CustomTextField(
                controller: widget.nameController,
                labelText: 'Nombre y Apellidos',
              ),
              SizedBox(height: responsive.heightPercent(2)),
              CustomTextField(
                controller: widget.emailController,
                labelText: 'Email de contacto',
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: responsive.heightPercent(2)),
              CustomTextField(
                controller: widget.dateController,
                labelText: 'Fecha de visualización',
                keyboardType: TextInputType.datetime,
              ),
              SizedBox(height: responsive.heightPercent(5)),
              isCompleted
                  ? Column(
                      children: [
                        PokeButton(
                          onTap: () {
                            clearFields();
                            context.go(NavigationRoutes.listRoute);
                          },
                        ),
                        SizedBox(height: responsive.heightPercent(2)),
                        Text(
                          'Pulsa en la pokeball para continuar',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: responsive.widthPercent(6), // Tamaño de fuente responsive
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
