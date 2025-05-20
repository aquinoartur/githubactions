import 'package:flutter/material.dart';
import 'package:githubactions/core/theme/app_theme.dart';
import 'package:githubactions/di/get_it_setup.dart';
import 'package:githubactions/home/home_screen.dart';

const appToken = 'test';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AppThemeMode themeMode;

  @override
  void initState() {
    themeMode = AppThemeMode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: themeMode,
      builder: (context, _) {
        return MaterialApp(
          title: 'Flutter Demo',
          themeMode: themeMode.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          theme: themeMode.isDarkMode
              ? AppThemeData.darkTheme
              : AppThemeData.lightTheme,
          home: const HomeScreen(),
        );
      },
    );
  }
}

class AppThemeData {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
  );
}
