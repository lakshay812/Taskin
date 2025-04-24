import 'package:flutter/material.dart';
import 'package:task_in_v2/config/routes/routes.dart';
import 'package:task_in_v2/config/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isDarkMode = prefs.getBool('isDarkMode') ?? false;
  
  runApp(MyApp(isDarkMode: isDarkMode));
}

class MyApp extends StatefulWidget {
  final bool isDarkMode;

  const MyApp({
    super.key,
    required this.isDarkMode,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool _isDarkMode;

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.isDarkMode;
    _setupThemeListener();
  }

  void _setupThemeListener() async {
    // Check theme preference periodically
    Future.delayed(const Duration(seconds: 1), () async {
      if (!mounted) return;
      
      final prefs = await SharedPreferences.getInstance();
      final newTheme = prefs.getBool('isDarkMode') ?? false;
      
      if (newTheme != _isDarkMode) {
        setState(() {
          _isDarkMode = newTheme;
        });
      }
      
      _setupThemeListener();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TaskIN',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      initialRoute: '/',
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}