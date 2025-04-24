import 'package:flutter/material.dart';
import 'package:task_in/features/home/data/services_data.dart';
import 'package:task_in/features/home/presentation/screens/booking_success_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:math';
import 'dart:io';
import 'package:lottie/lottie.dart';
import 'package:geocoding/geocoding.dart';

class BookingScreen extends StatefulWidget {
  final Shop shop;

  const BookingScreen({
    super.key,
    required this.shop,
  });

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  static const Color yellow = Color(0xFFFEC532);
  static const Color black = Color(0xFF161515);
  static const Color white = Color(0xFFF2F8FC);

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: 'Rudra Verma');
  final _contactController = TextEditingController(text: '9876543210');
  final _addressController = TextEditingController(text: '123 Main St, Bhopal');
  final _problemController = TextEditingController();
  bool _isLoading = false;
  bool _isSuccess = false;
  int? _estimatedPrice;
  File? _selectedImage;

  Future<void> _getCurrentLocation() async {
    try {
      final permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }

      final position = await Geolocator.getCurrentPosition();
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        setState(() {
          _addressController.text =
              '${place.street}, ${place.locality}, ${place.postalCode}';
        });
      }
    } catch (e) {
      debugPrint('Error getting location: $e');
    }
  }

  Future<void> _openMap() async {
    try {
      final availableMaps = await MapLauncher.installedMaps;
      if (availableMaps.isNotEmpty) {
        await availableMaps.first.showMarker(
          coords: Coords(23.2599, 77.4126), // Bhopal coordinates
          title: 'Select Location',
          description: 'Choose your service location',
        );
      }
    } catch (e) {
      debugPrint('Could not open map: $e');
    }
  }

  Future<void> _pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to pick image. Please try again.'),
        ),
      );
    }
  }

  Future<void> _takePhoto() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? photo = await picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (photo != null) {
        setState(() {
          _selectedImage = File(photo.path);
        });
      }
    } catch (e) {
      debugPrint('Error taking photo: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to take photo. Please try again.'),
        ),
      );
    }
  }

  void _handleBooking() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      await Future.delayed(const Duration(seconds: 2));

      final random = Random();
      _estimatedPrice = 300 + random.nextInt(201); // Random price between 300-500

      if (mounted) {
        setState(() {
          _isLoading = false;
          _isSuccess = true;
        });

        await Future.delayed(const Duration(seconds: 2));

        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const BookingSuccessScreen(),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isSuccess) {
      return Scaffold(
        body: Center(
          child: Lottie.network(
            'https://assets10.lottiefiles.com/packages/lf20_jbrw3hcz.json',
            width: 200,
            height: 200,
            repeat: false,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Your Service'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
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
                decoration: const InputDecoration(
                  labelText: 'Contact Number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your contact number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: 'Address',
                  border: const OutlineInputBorder(),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.my_location),
                        onPressed: _getCurrentLocation,
                      ),
                      IconButton(
                        icon: const Icon(Icons.map),
                        onPressed: _openMap,
                      ),
                    ],
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _problemController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Problem Description',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please describe your problem';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              if (_selectedImage != null) ...[
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: FileImage(_selectedImage!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _pickImage,
                      icon: const Icon(Icons.photo_library),
                      label: const Text('Gallery'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: yellow,
                        foregroundColor: black,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _takePhoto,
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Camera'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: yellow,
                        foregroundColor: black,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (_estimatedPrice != null) ...[
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Estimated Price',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '₹${_estimatedPrice}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _handleBooking,
                style: ElevatedButton.styleFrom(
                  backgroundColor: yellow,
                  foregroundColor: black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: black)
                    : const Text(
                        'Book Now',
                        style: TextStyle(fontSize: 16),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}