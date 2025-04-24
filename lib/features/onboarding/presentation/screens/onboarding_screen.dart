import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  bool _isLastPage = false;
  int _currentPage = 0;
  bool _isPressed = false;

  // Custom app colors
  static const Color yellow = Color(0xFFFEC532);
  static const Color black = Color(0xFF161515);
  static const Color white = Color(0xFFF2F8FC);

  @override
  void initState() {
    super.initState();
    // Auto scroll timer
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        _autoScroll();
      }
    });
  }

  void _autoScroll() {
    if (!mounted || _isLastPage) return;
    
    Future.delayed(const Duration(seconds: 3), () {
      if (_currentPage < 2 && mounted) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        _autoScroll();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
                _isLastPage = index == 2;
              });
            },
            children: [
              OnboardingPage(
                image: 'assets/images/onboarding_1.png',
                title: 'Support Local\nBusinesses',
                textColor: black,
              ),
              OnboardingPage(
                image: 'assets/images/onboarding_2.png',
                title: 'Realtime\nCommunication &\ntracking',
                textColor: black,
              ),
              OnboardingPage(
                image: 'assets/images/onboarding_3.png',
                title: 'Secure Payments',
                textColor: black,
              ),
            ],
          ),
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                count: 3,
                effect: const ExpandingDotsEffect(
                  activeDotColor: yellow,
                  dotColor: Colors.grey,
                  dotHeight: 8,
                  dotWidth: 8,
                  spacing: 8,
                ),
              ),
            ),
          ),
          if (_isLastPage)
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: _isLastPage ? 1.0 : 0.0,
                child: Center(
                  child: GestureDetector(
                    onTapDown: (_) => setState(() => _isPressed = true),
                    onTapUp: (_) {
                      setState(() => _isPressed = false);
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    onTapCancel: () => setState(() => _isPressed = false),
                    child: Container(
                      width: 180,
                      height: 48,
                      decoration: BoxDecoration(
                        color: yellow,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Text(
                            'Enter TaskIn',
                            style: TextStyle(
                              color: black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Positioned(
                            right: 16,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              transform: Matrix4.translationValues(
                                _isPressed ? 3.0 : 0.0,
                                0.0,
                                0.0,
                              ),
                              child: Icon(
                                Icons.arrow_forward,
                                color: black,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final Color textColor;

  const OnboardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: screenSize.width * 0.8,
          height: screenSize.height * 0.4,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Image.asset(
            image,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 32),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            height: 1.2,
            color: textColor,
          ),
        ),
      ],
    );
  }
}