import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:marvel/features/presentation/app.dart';
import 'injection_container.dart' as serviceLocator;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await serviceLocator.init();

  runApp(const App());
}
