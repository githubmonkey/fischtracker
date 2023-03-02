import 'package:fischtracker/src/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fischtracker/src/routing/app_router.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    return MaterialApp.router(
      routerConfig: goRouter,
      theme: ref.watch(theme),
      darkTheme: ref.watch(darkTheme),
      themeMode: ThemeMode.system,
      // ThemeData(
      //   primarySwatch: Colors.indigo,
      //   unselectedWidgetColor: Colors.grey,
      //   appBarTheme: const AppBarTheme(
      //     elevation: 2.0,
      //     centerTitle: true,
      //   ),
      //   scaffoldBackgroundColor: Colors.grey[200],
      // ),
      debugShowCheckedModeBanner: false,
    );
  }
}
