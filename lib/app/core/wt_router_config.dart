import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weathify/app/feature/home/home_screen.dart';

class WTRouterDefinition {
  WTRouterDefinition({required this.path, required this.name, this.params = const <String>[]});
  String name;
  String path;
  List<String> params;
}

class WTRouterConfig {
  WTRouterConfig({required this.rootNavigatorKey});
  final GlobalKey<NavigatorState> rootNavigatorKey;

  static final homeScreen = WTRouterDefinition(name: "homeScreen", path: "/");

  RouterConfig<Object> config() {
    final GoRouter router = GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: homeScreen.path,
      routes: [
        GoRoute(
          path: homeScreen.path,
          name: homeScreen.name,
          builder: (_, __) => HomeScreen.create(),
        )
      ],
    );
    return router;
  }

  void navigateToHomeScreen(BuildContext context) {
    if (context.mounted) return;
    Navigator.pushNamed(context, homeScreen.name);
  }
}
