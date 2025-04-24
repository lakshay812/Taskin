import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BecomeVendorScreen extends StatefulWidget {
  const BecomeVendorScreen({super.key});

  @override
  State<BecomeVendorScreen> createState() => _BecomeVendorScreenState();
}

class _BecomeVendorScreenState extends State<BecomeVendorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  final _searchController = TextEditingController();
  final List<String> _selectedCategories = [];
  bool _acceptTerms = false;
  bool _isLoading = false;

  final List<String> _availableCategories = [
    'Electronics Repair',
    'Laundry',
    'Cleaning',
    'Plumbing',
    'Carpenter',
    'AC Servicing',
    'Porter Delivery',
    'Health & Medical',
    'Home delivery',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _contactController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _toggleCategory(String category) {
    setState(() {
      if (_selectedCategories.contains(category)) {
        _selectedCategories.remove(category);
      } else {
        _selectedCategories.add(category);
      }
    });
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate() && _acceptTerms) {
      setState(() {
        _isLoading = true;
      });

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      if (!mounted) return;

      // Save vendor status and details
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isVendor', true); // Set as vendor directly
      await prefs.setString('vendorName', _nameController.text);
      await prefs.setString('vendorContact', _contactController.text);
      await prefs.setStringList('vendorCategories', _selectedCategories);

      Navigator.pop(
          context, true); // Return true to indicate successful submission
    } else if (!_acceptTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please accept the Terms and Conditions'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Become a Vendor'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Join TaskIN to connect with local customers and expand your business!',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Vendor Details',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Full name',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _contactController,
                        decoration: InputDecoration(
                          labelText: 'Contact Number',
                          border: const OutlineInputBorder(),
                          prefixText: '+91 ',
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your contact number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Service Category',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search Service',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _availableCategories
                            .where((category) => category
                                .toLowerCase()
                                .contains(_searchController.text.toLowerCase()))
                            .map((category) {
                          final isSelected =
                              _selectedCategories.contains(category);
                          return FilterChip(
                            label: Text(category),
                            selected: isSelected,
                            onSelected: (_) => _toggleCategory(category),
                            backgroundColor: Colors.grey[200],
                            selectedColor: Colors.orange[100],
                            checkmarkColor: Colors.orange,
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        'Key Benefits',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildBenefitItem(
                        icon: LineIcons.users,
                        title:
                            'Connect with local customers looking for services in your area, helping you find work.',
                      ),
                      const SizedBox(height: 12),
                      _buildBenefitItem(
                        icon: LineIcons.wallet,
                        title:
                            'Get paid safely through the app\'s secure payment system, with easy job tracking.',
                      ),
                      const SizedBox(height: 12),
                      _buildBenefitItem(
                        icon: LineIcons.lineChart,
                        title:
                            'Gain visibility, receive feedback, and build your reputation to attract more clients.',
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        'Terms and Conditions Agreement',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'By continuing, you confirm that you have read and agree to the Terms and Conditions of TaskIN. This includes our policies on secure payments, user privacy, and service transactions. TaskIN connects you with local service providers, ensuring a safe and reliable experience for all parties.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Checkbox(
                            value: _acceptTerms,
                            onChanged: (value) {
                              setState(() {
                                _acceptTerms = value ?? false;
                              });
                            },
                          ),
                          const Expanded(
                            child: Text(
                                'I have read and agree to the Terms and Conditions.'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  16, 8, 16, MediaQuery.of(context).padding.bottom + 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Become a Vendor',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefitItem({
    required IconData icon,
    required String title,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.orange[50],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: Colors.orange,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}
