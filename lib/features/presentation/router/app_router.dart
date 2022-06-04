import 'package:flutter/material.dart';
import 'package:marvel/features/domain/entities/character.dart';
import 'package:marvel/features/presentation/pages/details_page/details_page.dart';
import 'package:marvel/features/presentation/pages/home_page/home_page.dart';

Route<dynamic>? generateRoutes(RouteSettings settings) {
  
  if (settings.name == HomePage.routeName) {
    return MaterialPageRoute(
      builder: (_) => const HomePage(),
    );
  }

  if (settings.name == DetailsPage.routeName) {
    final character = settings.arguments as Character;

    return MaterialPageRoute(
      builder: (_) => DetailsPage(
        character: character,
      ),
    );
  }

  assert(false, 'Need to implement ${settings.name}');

  return null;
}
