import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final void Function()? onPressed;
  final bool searchPressed;
  final Function()? callBackButton;
  final Function(String query)? callBackSearch;

  const SearchCustomAppBar({
    super.key,
    required this.title, 
    this.onPressed, 
    required this.searchPressed, 
    this.callBackButton,
    this.callBackSearch,
  });

  @override
  Widget build(BuildContext context) {
    return 
    AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      title: searchPressed ? 
      TextField(
        onChanged: (value){
          callBackSearch!(value);
        },
        decoration: const InputDecoration(
          hintText: "Buscar...",
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
            callBackButton!();
          },
          color: Colors.black,
        )
        :
        IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: context.pop,
          color: Colors.black,
        ),
    );

  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}