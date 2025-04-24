import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About TaskIn'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/images/taskin_logo_light.png',
                height: 100,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'TaskIn is a revolutionary local services platform designed specifically for rural and tier-2 cities in India. Our mission is to bridge the gap between skilled service providers and customers, making essential services easily accessible to everyone. We connect users with verified professionals across multiple categories including electronics repair, laundry, cleaning, plumbing, carpentry, AC servicing, and healthcare.\n\nWhat sets TaskIn apart is our focus on empowering local businesses while ensuring quality service delivery through our rigorous verification process and rating system. We understand the unique challenges of smaller cities and have built features that work seamlessly even in areas with limited connectivity. Our platform supports multiple regional languages and offers both online and offline booking options.\n\nWith TaskIn, we\'re not just providing a service marketplace; we\'re building a community that supports local entrepreneurship, creates employment opportunities, and improves access to essential services. Our integrated emergency services feature ensures that help is just a tap away when needed. Join us in our journey to transform how services are discovered, booked, and delivered in emerging India.',
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            const ListTile(
              leading: Icon(LineIcons.code),
              title: Text('Version'),
              trailing: Text('1.0.0'),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(LineIcons.globe),
              title: const Text('Website'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              leading: const Icon(LineIcons.fileAlt),
              title: const Text('Terms of Service'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              leading: const Icon(LineIcons.userShield),
              title: const Text('Privacy Policy'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}