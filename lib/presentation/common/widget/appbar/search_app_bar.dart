import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchCustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final void Function()? onPressed;
  final bool searchPressed;
  final Function()? callBackButton;
  final Function(String query)? callBackSearch;
  String? initialQuery; // Para recordar lo que se escribió antes

  SearchCustomAppBar({
    super.key,
    required this.title,
    this.onPressed,
    required this.searchPressed,
    this.callBackButton,
    this.callBackSearch,
    this.initialQuery, // Parámetro opcional
  });

  @override
  State<SearchCustomAppBar> createState() => _SearchCustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SearchCustomAppBarState extends State<SearchCustomAppBar> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    // Inicializar el controlador con el texto previo (si existe)
    _controller = TextEditingController(text: widget.initialQuery ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      title: widget.searchPressed
          ? TextField(
              controller: _controller, // Vinculamos el controlador
              onChanged: (value) {
                widget.initialQuery = value; // Guardar el texto actual
                widget.callBackSearch?.call(value);
              },
              decoration: const InputDecoration(
                hintText: "Busca tu Pokemon...",
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontFamily: "8bits",
                ),
              ),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontFamily: "8bits",
              ),
            )
          : Text(
              widget.title,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: "PokemonFont",
              ),
            ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: widget.onPressed,
          color: Colors.black,
        ),
      ],
      leading: widget.searchPressed
          ? IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                widget.callBackButton?.call();
              },
              color: Colors.black,
            )
          : IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: context.pop,
              color: Colors.black,
            ),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Liberar recursos del controlador
    super.dispose();
  }
}
