import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyServiceScreen extends StatelessWidget {
  final String title;
  final String description;
  final String phoneNumber;
  final List<String> instructions;
  final Color color;
  final IconData icon;

  const EmergencyServiceScreen({
    super.key,
    required this.title,
    required this.description,
    required this.phoneNumber,
    required this.instructions,
    required this.color,
    required this.icon,
  });

  Future<void> _makeCall() async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    try {
      await launchUrl(phoneUri);
    } catch (e) {
      debugPrint('Could not launch phone app: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: color.withOpacity(0.1),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              color: color.withOpacity(0.1),
              child: Column(
                children: [
                  Icon(
                    icon,
                    size: 64,
                    color: color,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Emergency Instructions',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: instructions.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: color.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '${index + 1}',
                                style: TextStyle(
                                  color: color,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                instructions[index],
                                style: const TextStyle(
                                  fontSize: 16,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: _makeCall,
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.phone),
                const SizedBox(width: 8),
                Text(
                  'Call $phoneNumber',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}