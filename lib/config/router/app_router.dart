import 'package:go_router/go_router.dart';
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
      ]
    ),
  ]
);