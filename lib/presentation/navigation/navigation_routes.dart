import 'package:go_router/go_router.dart';
import 'package:pokeview/model/pokemon.dart';
import 'package:pokeview/presentation/view/screens.dart';
import 'package:flutter/widgets.dart';


abstract class NavigationRoutes {
  // Route names
  static const String initialRoute = '/';
  static const String listRoute = 'list';
  static const String detailRoute = 'detail';
}

// Nav keys
final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _pokemonNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: NavigationRoutes.initialRoute,
  routes: [
    // Ruta principal
    GoRoute(
      path: NavigationRoutes.initialRoute,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const MainScreen(),
    ),

    // StatefulShellRoute para mantener el estado entre pestañas
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) => MainScreen(),
      branches: [
        // Pestaña de Pokémon
        StatefulShellBranch(navigatorKey: _pokemonNavigatorKey, routes: [
          GoRoute(
            path: NavigationRoutes.listRoute,
            parentNavigatorKey: _pokemonNavigatorKey,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: ListScreen()),
            routes: [
              // Detalle del Pokémon
              GoRoute(
                path: NavigationRoutes.detailRoute,
                builder: (context, state) {
                  final extra = state.extra as Pokemon;
                  return DetailScreen(pokemon: extra);
                },
              ),
            ],
          ),
        ]),
  ],
)]);
