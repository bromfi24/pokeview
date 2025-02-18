import 'package:go_router/go_router.dart';
import 'package:pokeview/domain/entities/pokemon.dart';
import 'package:pokeview/presentation/screens/screens.dart';


final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: MainScreen.routeName,
      builder: (context, state) => const MainScreen(),
      routes: [
        GoRoute(
          path: 'list',
          name: ListScreen.routeName,
          builder: (context, state) => const ListScreen(),
        ),
        GoRoute(
        path: 'detail',
        name: DetailScreen.routeName,  // Asegúrate de que el nombre de la ruta sea único
        builder: (context, state) {
          final pokemon = state.extra as Pokemon; // Accede al objeto Pokémon
          return DetailScreen(pokemon: pokemon); // Pasa el objeto al widget
        },
      ),
      ]
    ),
  ]
);