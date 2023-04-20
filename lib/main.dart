import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import './views/home.dart';
import './views/cocktail.dart';

void main() {
  runApp(MaterialApp.router(routerConfig: router));
}

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (_, __) => const HomePage(),
      routes: [
        GoRoute(
          path: 'cocktail/:id',
          builder: (context, state) {
            return CocktailPage(
              id: state.params["id"]!,
            );
          },
        ),
      ],
    ),
  ],
);
