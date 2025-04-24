import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:task_in/features/home/presentation/screens/tabs/home_tab.dart';
import 'package:task_in/features/home/presentation/screens/tabs/emergency_tab.dart';
import 'package:task_in/features/home/presentation/screens/tabs/game_tab.dart';
import 'package:task_in/features/home/presentation/screens/tabs/settings_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _tabs = [
    HomeTab(),
    EmergencyTab(),
    GameTab(),
    SettingsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? Colors.grey[900] : Colors.white;
    final rippleColor = isDarkMode ? Colors.grey[800] : Colors.grey[300];
    final hoverColor = isDarkMode ? Colors.grey[800] : Colors.grey[100];
    final tabBackgroundColor = isDarkMode ? Colors.grey[800] : Colors.grey[100];
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      body: _tabs[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: rippleColor!,
              hoverColor: hoverColor!,
              gap: 8,
              activeColor: textColor,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: tabBackgroundColor!,
              color: textColor,
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: LineIcons.ambulance,
                  text: 'Emergency',
                ),
                GButton(
                  icon: LineIcons.gamepad,
                  text: 'Game',
                ),
                GButton(
                  icon: LineIcons.cog,
                  text: 'Settings',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
  