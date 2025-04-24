import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _formKey = GlobalKey<FormState>();
  final _feedbackController = TextEditingController();
  int _selectedRating = 0;

  void _submitFeedback() {
    if (_formKey.currentState!.validate() && _selectedRating > 0) {
      // TODO: Implement feedback submission
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Thank you for your feedback!'),
        ),
      );
      Navigator.pop(context);
    } else if (_selectedRating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a rating'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Feedback'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'How would you rate your experience?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      index < _selectedRating
                          ? LineIcons.starAlt
                          : LineIcons.star,
                      color: index < _selectedRating
                          ? Colors.orange
                          : Colors.grey,
                      size: 32,
                    ),
                    onPressed: () {
                      setState(() {
                        _selectedRating = index + 1;
                      });
                    },
                  );
                }),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _feedbackController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Your Feedback',
                  hintText: 'Tell us about your experience...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your feedback';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitFeedback,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Submit Feedback'),
              ),
              const SizedBox(height: 32),
              const Text(
                'Contact Support',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(LineIcons.envelope),
                title: const Text('Email Support'),
                subtitle: const Text('support@taskin.com'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(LineIcons.phone),
                title: const Text('Phone Support'),
                subtitle: const Text('+91 1800-123-4567'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(LineIcons.whatSApp),
                title: const Text('WhatsApp Support'),
                subtitle: const Text('+91 9876543210'),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}