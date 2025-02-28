import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokeview/presentation/common/resources/constants.dart';
import 'package:pokeview/model/pokemon.dart';
import 'package:pokeview/presentation/common/resources/responsive.dart';
import 'package:pokeview/presentation/common/resources/shadowed_image.dart';

class PokemonView extends StatelessWidget {
  final Pokemon pokemon;
  const PokemonView({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return GestureDetector(
      onTap: () {
        context.push('/detail', extra: pokemon);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: responsive.heightPercent(1)),
        padding: EdgeInsets.all(responsive.widthPercent(3)),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: PokemonInfo(pokemon: pokemon),
            ),
            ShadowedImage(
              imageUrl: pokemon.imagesUrl[0],
              width: responsive.widthPercent(20),
              height: responsive.widthPercent(20),
              shadowColor: Constants.typeColors[pokemon.types[0]] ?? Colors.white,
            ),
            SizedBox(width: responsive.widthPercent(3)),
          ],
        ),
      ),
    );
  }
}

class PokemonInfo extends StatelessWidget {
  const PokemonInfo({
    super.key,
    required this.pokemon,
  });

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Image.asset(
              'assets/images/pokeball.png',
              width: responsive.widthPercent(5),
              height: responsive.widthPercent(5),
            ),
            Text(
              pokemon.id.toString(),
              style: TextStyle(
                fontSize: responsive.widthPercent(8),
                fontWeight: FontWeight.bold,
                fontFamily: "8bits",
              ),
            ),
          ],
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                pokemon.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: responsive.widthPercent(10),
                  fontWeight: FontWeight.bold,
                  fontFamily: "8bits",
                ),
              ),
              SizedBox(height: responsive.heightPercent(1.5)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: pokemon.types.map((type) {
                  String imagePath = '${Constants.ROUTE_ASSETS_TYPE}$type.png';
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: responsive.widthPercent(1)),
                    child: Image.asset(
                      imagePath,
                      width: responsive.widthPercent(10),
                      height: responsive.widthPercent(10),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
