import 'package:fischtracker/src/utils/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fischtracker/src/routing/app_router.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    final myThemeState = ref.watch(myThemeProvider);
    return MaterialApp.router(
      routerConfig: goRouter,
      theme: myThemeState.theme,
      darkTheme: myThemeState.darkTheme,
      themeMode: myThemeState.themeMode,
      debugShowCheckedModeBanner: false,
    );
  }
}
