import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokeview/presentation/view/home/home_page.dart';
import 'package:pokeview/presentation/view/screens.dart';
import 'package:flutter/widgets.dart';

abstract class NavigationRoutes {
  static const String initialRoute = '/';
  static const String listRoute = '/list';
  static const String detailRoute = '/detail';
  static const String favoriteRoute = '/favorite';
}

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: NavigationRoutes.initialRoute,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => HomePage(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: NavigationRoutes.listRoute,
              pageBuilder: (context, state) => const NoTransitionPage(child: ListScreen(isList: true)),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: NavigationRoutes.favoriteRoute,
              pageBuilder: (context, state) => const NoTransitionPage(child: ListScreen(isList: false)),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: NavigationRoutes.initialRoute,
      builder: (context, state) => const MainScreen(),
    ),
    GoRoute(
      path: NavigationRoutes.detailRoute,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return DetailScreen(pokemon: extra['pokemon'], onDelete: extra['onDelete']);
      },
    ),
  ],
);

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: _getBottomNavigationBar(),
    );
  }

  Widget _getBottomNavigationBar() {
    return Container(
      color: Colors.white,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: widget.navigationShell.currentIndex,
          type: BottomNavigationBarType.fixed,
          enableFeedback: false,
          onTap: (index) {
            widget.navigationShell.goBranch(
              index,
              initialLocation: index == widget.navigationShell.currentIndex,
            );
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              activeIcon: Icon(Icons.list, color: Colors.red),
              label: 'Lista',
              
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              activeIcon: Icon(Icons.favorite, color: Colors.red),
              label: 'Favoritos',
            ),
          ],
        ),
      ),
    );
  }
}