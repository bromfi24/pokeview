import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final void Function()? onPressed;
  final bool searchPressed;
  final Function()? callBack;

  const SearchCustomAppBar({
    super.key,
    required this.title, this.onPressed, required this.searchPressed, this.callBack,
  });

  @override
  Widget build(BuildContext context) {
    return 
    AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      title: searchPressed ? 
      TextField(
        decoration: const InputDecoration(
          hintText: "Buscar...",
          border: InputBorder.none,
        ),
      ) 
      :
      Text(
        title,
        style: const TextStyle(
          fontSize:30,
          fontWeight: FontWeight.bold,
          fontFamily: "PokemonFont",),
      ),
      actions: [
        IconButton(
        icon: const Icon(Icons.search),
        onPressed: onPressed,
        color: Colors.black,
        ),
      ],
      leading:
        searchPressed ?
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: (){
            callBack!();
          },
        )
        :
        IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: context.pop,
        ),
    );

  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}