import 'package:flutter/material.dart';
import 'package:marvel/theme/theme.dart';
import 'package:marvel/features/presentation/router/app_router.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Marvel',
      onGenerateRoute: generateRoutes,
      theme: marvelTheme,
    );
  }
}
