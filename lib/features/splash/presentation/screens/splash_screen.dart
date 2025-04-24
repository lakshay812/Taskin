import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.6, 1.0),
      ),
    );

    // Start the size animation after a short delay
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _isExpanded = true;
        });
      }
    });

    // Start fade out animation after 2 seconds
    Future.delayed(const Duration(milliseconds: 2000), () {
      _controller.forward();
    });

    // Navigate to onboarding after animations
    Future.delayed(const Duration(milliseconds: 2800), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/onboarding');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
            width: _isExpanded ? 220 : 180,
            height: _isExpanded ? 220 : 180,
            child: SvgPicture.asset(
              'assets/images/splash_light.svg',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}