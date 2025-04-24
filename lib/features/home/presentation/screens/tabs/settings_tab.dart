import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_in/features/home/presentation/screens/settings/edit_profile_screen.dart';
import 'package:task_in/features/home/presentation/screens/settings/booked_services_screen.dart';
import 'package:task_in/features/home/presentation/screens/settings/feedback_screen.dart';
import 'package:task_in/features/home/presentation/screens/settings/about_screen.dart';
import 'package:task_in/features/vendor/presentation/screens/become_vendor_screen.dart';
import 'package:task_in/features/vendor/presentation/screens/vendor_dashboard_screen.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  bool _isDarkMode = false;
  bool _isVendor = false;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
      _isVendor = prefs.getBool('isVendor') ?? false;
    });
  }

  Future<void> _toggleTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', value);
    setState(() {
      _isDarkMode = value;
    });
  }

  void _shareApp() {
    Share.share(
      'Check out TaskIn - Your one-stop solution for local services! Download now: [App Store Link]',
      subject: 'TaskIn - Local Services App',
    );
  }

  Future<void> _handleVendorAction() async {
    if (_isVendor) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const VendorDashboardScreen(),
        ),
      );
    } else {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const BecomeVendorScreen(),
        ),
      );
      if (result == true) {
        _loadPreferences();
      }
    }
  }

  Future<void> _signOut(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Sign Out',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );

    if (result == true && mounted) {
      // Clear vendor status on sign out
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('isVendor');
      await prefs.remove('vendorName');
      await prefs.remove('vendorContact');
      await prefs.remove('vendorCategories');

      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/login',
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey,
                child: Icon(
                  LineIcons.user,
                  size: 50,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Rudra Verma',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'rudraverma+vit@email.com',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 32),
              SettingsSection(
                items: [
                  SettingsItem(
                    icon: LineIcons.userEdit,
                    title: 'Edit Profile',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditProfileScreen(),
                      ),
                    ),
                  ),
                  SettingsItem(
                    icon: LineIcons.adjust,
                    title: 'Dark Mode',
                    trailing: Switch(
                      value: _isDarkMode,
                      onChanged: _toggleTheme,
                    ),
                    onTap: () {},
                  ),
                  SettingsItem(
                    icon: LineIcons.history,
                    title: 'Booked Services',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BookedServicesScreen(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: _handleVendorAction,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _isVendor ? LineIcons.store : LineIcons.alternateStore,
                        color: Colors.green[700],
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          _isVendor
                              ? 'Go to Vendor Dashboard'
                              : 'Register as Partner',
                          style: TextStyle(
                            color: Colors.green[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.green[700],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SettingsSection(
                items: [
                  SettingsItem(
                    icon: LineIcons.share,
                    title: 'Recommend to Friends',
                    onTap: _shareApp,
                  ),
                  SettingsItem(
                    icon: LineIcons.questionCircle,
                    title: 'Help & Feedback',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FeedbackScreen(),
                      ),
                    ),
                  ),
                  SettingsItem(
                    icon: LineIcons.infoCircle,
                    title: 'About',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AboutScreen(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ElevatedButton(
                  onPressed: () => _signOut(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[50],
                    foregroundColor: Colors.red,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Sign Out'),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsSection extends StatelessWidget {
  final List<SettingsItem> items;

  const SettingsSection({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: items.map((item) {
          final isLast = items.indexOf(item) == items.length - 1;
          return Column(
            children: [
              ListTile(
                leading: Icon(item.icon),
                title: Text(item.title),
                trailing: item.trailing ??
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    ),
                onTap: item.onTap,
              ),
              if (!isLast)
                const Divider(
                  height: 0,
                  indent: 56,
                ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class SettingsItem {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback onTap;

  const SettingsItem({
    required this.icon,
    required this.title,
    this.trailing,
    required this.onTap,
  });
}
