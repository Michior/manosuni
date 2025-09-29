import 'package:flutter/material.dart';
import 'package:manosuni/theme/app_theme.dart';
import 'package:manosuni/app_router.dart'; 

void main() {
  runApp(const MyApp());
}

ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, currentMode, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'ManosUni',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: currentMode,
          initialRoute: AppRouter.initialRoute, 
          routes: AppRouter.routes, 
        );
      },
    );
  }
}
