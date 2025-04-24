import 'package:flutter/material.dart';
import 'package:task_in/features/home/presentation/screens/home_screen.dart';
import 'package:task_in/features/splash/presentation/screens/splash_screen.dart';
import 'package:task_in/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:task_in/features/auth/presentation/screens/login_screen.dart';
import 'package:task_in/features/auth/presentation/screens/signup_screen.dart';
import 'package:task_in/features/auth/presentation/screens/profile_completion_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/onboarding':
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/signup':
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case '/profile-completion':
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => ProfileCompletionScreen(
            userName: args?['userName'] ?? '',
            email: args?['email'] ?? '',
          ),
        );
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}