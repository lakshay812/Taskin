import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:task_in/features/home/data/services_data.dart';
import 'package:task_in/features/home/presentation/screens/service_details_screen.dart';
import 'package:task_in/features/home/presentation/screens/shop_details_screen.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final TextEditingController _searchController = TextEditingController();
  List<MapEntry<String, List<Shop>>> _searchResults = [];
  final FocusNode _focusNode = FocusNode();
  bool _showDropdown = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _focusNode.addListener(() {
      setState(() {
        _showDropdown = _focusNode.hasFocus && _searchResults.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _showDropdown = false;
      });
      return;
    }

    final results = ServiceData.services.entries
        .where((entry) => entry.key.toLowerCase().contains(query))
        .map((entry) {
      // Sort shops by rating and take top 2
      final topShops = List<Shop>.from(entry.value.shops)
        ..sort((a, b) => b.rating.compareTo(a.rating))
        ..take(2)
        .toList();
      return MapEntry(entry.key, topShops);
    }).toList();

    setState(() {
      _searchResults = results;
      _showDropdown = _focusNode.hasFocus && results.isNotEmpty;
    });
  }

  void _navigateToShop(Shop shop) {
    _searchController.clear();
    setState(() {
      _showDropdown = false;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ShopDetailsScreen(shop: shop),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Good Morning,',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 16,
                                backgroundColor: Colors.orange,
                                child: Text(
                                  'RV',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              const Text(
                                'Rudra',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(LineIcons.bell),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: _searchController,
                      focusNode: _focusNode,
                      decoration: InputDecoration(
                        hintText: 'Search services...',
                        prefixIcon: Icon(LineIcons.search, color: Colors.grey[600]),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Services',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 240,
                    child: GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 4,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.85,
                      children: const [
                        ServiceCard(
                          imagePath: 'assets/images/Tools.png',
                          label: 'Electronics Repair',
                        ),
                        ServiceCard(
                          imagePath: 'assets/images/washing_machine.png',
                          label: 'Laundry',
                        ),
                        ServiceCard(
                          imagePath: 'assets/images/Broom.png',
                          label: 'Cleaning',
                        ),
                        ServiceCard(
                          imagePath: 'assets/images/Plumbing.png',
                          label: 'Plumbing',
                        ),
                        ServiceCard(
                          imagePath: 'assets/images/Drawing.png',
                          label: 'Carpenter',
                        ),
                        ServiceCard(
                          imagePath: 'assets/images/ac_icon.png',
                          label: 'AC Servicing',
                        ),
                        ServiceCard(
                          imagePath: 'assets/images/big_parcel.png',
                          label: 'Porter Delivery',
                        ),
                        ServiceCard(
                          imagePath: 'assets/images/Stethoscope.png',
                          label: 'Health & Medical',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Popular Shops',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Column(
                    children: [
                      ShopCard(
                        shop: ServiceData.services['Electronics Repair']!.shops[0],
                      ),
                      const SizedBox(height: 16),
                      ShopCard(
                        shop: ServiceData.services['Laundry']!.shops[0],
                      ),
                      const SizedBox(height: 16),
                      ShopCard(
                        shop: ServiceData.services['Cleaning']!.shops[0],
                      ),
                      const SizedBox(height: 16),
                      ShopCard(
                        shop: ServiceData.services['Plumbing']!.shops[0],
                      ),
                      const SizedBox(height: 16),
                      ShopCard(
                        shop: ServiceData.services['Carpenter']!.shops[0],
                      ),
                      const SizedBox(height: 16),
                      ShopCard(
                        shop: ServiceData.services['AC Servicing']!.shops[0],
                      ),
                      const SizedBox(height: 16),
                      ShopCard(
                        shop: ServiceData.services['Porter Delivery']!.shops[0],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (_showDropdown)
              Positioned(
                top: 120,
                left: 16,
                right: 16,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      final category = _searchResults[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              category.key,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          ...category.value.map((shop) => ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    shop.image,
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                title: Text(shop.name),
                                subtitle: Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 16,
                                      color: Colors.yellow[700],
                                    ),
                                    const SizedBox(width: 4),
                                    Text(shop.rating.toString()),
                                  ],
                                ),
                                onTap: () => _navigateToShop(shop),
                              )),
                          if (index < _searchResults.length - 1)
                            const Divider(height: 1),
                        ],
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String imagePath;
  final String label;

  const ServiceCard({
    super.key,
    required this.imagePath,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final serviceInfo = ServiceData.services[label];
        if (serviceInfo != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ServiceDetailsScreen(
                serviceName: label,
                bannerImage: serviceInfo.bannerImage,
                shops: serviceInfo.shops,
              ),
            ),
          );
        }
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(
              imagePath,
              width: 24,
              height: 24,
              color: const Color(0xFFFEC532), // Yellow color
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class ShopCard extends StatelessWidget {
  final Shop shop;

  const ShopCard({
    super.key,
    required this.shop,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShopDetailsScreen(shop: shop),
          ),
        );
      },
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                shop.image,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.8),
                      Colors.transparent,
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      shop.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        ...List.generate(5, (index) {
                          return Icon(
                            index < shop.rating.floor()
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.yellow,
                            size: 18,
                          );
                        }),
                        const SizedBox(width: 4),
                        Text(
                          shop.rating.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}