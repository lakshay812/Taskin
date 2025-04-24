import 'package:flutter/material.dart';
import 'package:task_in/features/home/data/services_data.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:task_in/features/home/presentation/screens/booking_screen.dart';
import 'package:map_launcher/map_launcher.dart';

class ShopDetailsScreen extends StatelessWidget {
  final Shop shop;
  static const Color yellow = Color(0xFFFEC532);

  const ShopDetailsScreen({
    super.key,
    required this.shop,
  });

  void _makePhoneCall() async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: '9560731970',
    );
    try {
      await launchUrl(phoneUri);
    } catch (e) {
      debugPrint('Could not launch phone app: $e');
    }
  }

  void _openMap(BuildContext context) async {
    try {
      final availableMaps = await MapLauncher.installedMaps;
      if (availableMaps.isNotEmpty) {
        await availableMaps.first.showMarker(
          coords: Coords(23.2599, 77.4126), // Bhopal coordinates
          title: shop.name,
          description: shop.address,
        );
      }
    } catch (e) {
      debugPrint('Could not open map: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  shop.image,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 40,
                  left: 16,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          shop.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow[700],
                            size: 24,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            shop.rating.toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    shop.description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Address',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          shop.address,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.map),
                        onPressed: () => _openMap(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _makePhoneCall,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: yellow,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Contact'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookingScreen(shop: shop),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: yellow,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Book Now'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}