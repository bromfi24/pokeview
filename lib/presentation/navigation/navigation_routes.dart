import 'package:go_router/go_router.dart';
import 'package:pokeview/model/pokemon.dart';
import 'package:pokeview/presentation/view/screens.dart';
import 'package:flutter/widgets.dart';


abstract class NavigationRoutes {
  // Route names
  static const String initialRoute = '/';
  static const String listRoute = '/list';
  static const String detailRoute = '/detail';
}

// Nav keys
final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: NavigationRoutes.initialRoute,
  routes: [
    GoRoute(
      path: NavigationRoutes.initialRoute,
      builder: (context, state) => const MainScreen(),
    ),
    GoRoute(
      path: NavigationRoutes.listRoute,
      builder: (context, state) => const ListScreen(),
    ),
    GoRoute(
      path: NavigationRoutes.detailRoute,
      builder: (context, state) {
        final extra = state.extra as Pokemon;
        return DetailScreen(pokemon: extra);
      },
    ),
  ],
);ñ
