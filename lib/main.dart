import 'package:clean_architecture_demo/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/route_generator.dart';

void main() {
  runApp(const ProviderScope(child: LibraryApp()));
}

class LibraryApp extends StatelessWidget {
  const LibraryApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    themeMode: .light,
    theme: ThemeData(
      fontFamily: 'Arimo',
      scaffoldBackgroundColor: Colors.white,
    ),
    debugShowCheckedModeBanner: false,
    supportedLocales: L10n.supportedLocales,
    localizationsDelegates: L10n.localizationsDelegates,
    onGenerateTitle: (context) => L10n.of(context).appName,
    initialRoute: '/',
    onGenerateRoute: RouteGenerator.onGenerateRoute,
  );
}
