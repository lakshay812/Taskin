import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:task_in/features/home/presentation/screens/emergency/emergency_service_screen.dart';

class EmergencyTab extends StatelessWidget {
  const EmergencyTab({super.key});

  void _openEmergencyService(BuildContext context, EmergencyService service) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EmergencyServiceScreen(
          title: service.title,
          description: service.description,
          phoneNumber: service.phoneNumber,
          instructions: service.instructions,
          color: service.color,
          icon: service.icon,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red[100],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        LineIcons.exclamationTriangle,
                        color: Colors.red[700],
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Emergency Services',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.red[700],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Quick access to emergency services. Tap to call immediately.',
                            style: TextStyle(
                              color: Colors.red[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Medical Services',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: medicalServices.length,
                itemBuilder: (context, index) {
                  final service = medicalServices[index];
                  return EmergencyServiceCard(
                    service: service,
                    onTap: () => _openEmergencyService(context, service),
                  );
                },
              ),
              const SizedBox(height: 24),
              const Text(
                'Safety & Security',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: safetyServices.length,
                itemBuilder: (context, index) {
                  final service = safetyServices[index];
                  return EmergencyServiceCard(
                    service: service,
                    onTap: () => _openEmergencyService(context, service),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmergencyServiceCard extends StatelessWidget {
  final EmergencyService service;
  final VoidCallback onTap;

  const EmergencyServiceCard({
    super.key,
    required this.service,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: service.color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            service.icon,
            color: service.color,
            size: 24,
          ),
        ),
        title: Text(
          service.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          service.shortDescription,
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}

class EmergencyService {
  final String title;
  final String shortDescription;
  final String description;
  final String phoneNumber;
  final List<String> instructions;
  final Color color;
  final IconData icon;

  const EmergencyService({
    required this.title,
    required this.shortDescription,
    required this.description,
    required this.phoneNumber,
    required this.instructions,
    required this.color,
    required this.icon,
  });
}

final List<EmergencyService> medicalServices = [
  EmergencyService(
    title: 'Ambulance Service',
    shortDescription: '24/7 Emergency Medical Transport',
    description: 'Immediate medical transport service with trained paramedics. Available 24/7 for emergency situations.',
    phoneNumber: '108',
    color: Colors.red,
    icon: LineIcons.ambulance,
    instructions: [
      'Stay calm and speak clearly when calling',
      'Provide exact location with landmarks',
      'Describe the emergency situation briefly',
      'Follow the operator\'s instructions',
      'Keep the patient still and comfortable',
      'Clear the path for the ambulance arrival',
    ],
  ),
  EmergencyService(
    title: 'Medical Consultation',
    shortDescription: 'Immediate Medical Advice',
    description: 'Get immediate medical advice from qualified doctors for emergency situations.',
    phoneNumber: '104',
    color: Colors.blue,
    icon: LineIcons.stethoscope,
    instructions: [
      'Describe your symptoms clearly',
      'Have your medical history ready',
      'Keep a pen and paper for notes',
      'Ask about medication interactions',
      'Follow up with your regular doctor',
    ],
  ),
  EmergencyService(
    title: 'Blood Bank',
    shortDescription: 'Emergency Blood Requirements',
    description: 'Connect with blood banks for emergency blood requirements. Available 24/7.',
    phoneNumber: '1910',
    color: Colors.red,
    icon: LineIcons.tint,
    instructions: [
      'Know the required blood group',
      'Specify quantity needed',
      'Have a prescription ready',
      'Arrange transport if needed',
      'Keep donor contact information',
    ],
  ),
];

final List<EmergencyService> safetyServices = [
  EmergencyService(
    title: 'Police',
    shortDescription: 'Emergency Police Assistance',
    description: 'Immediate police assistance for emergencies and security situations.',
    phoneNumber: '100',
    color: Colors.blue,
    icon: LineIcons.userShield,
    instructions: [
      'Stay calm and speak clearly',
      'Provide exact location details',
      'Describe the situation briefly',
      'Follow police instructions',
      'Stay in a safe location',
      'Document any relevant details',
    ],
  ),
  EmergencyService(
    title: 'Fire Service',
    shortDescription: 'Fire Emergency Response',
    description: 'Immediate response for fire emergencies with trained firefighters.',
    phoneNumber: '101',
    color: Colors.orange,
    icon: LineIcons.fire,
    instructions: [
      'Evacuate the area immediately',
      'Call from a safe location',
      'Provide exact address',
      'Describe type of fire',
      'Don\'t attempt to fight large fires',
      'Help others evacuate safely',
    ],
  ),
  EmergencyService(
    title: 'Women\'s Helpline',
    shortDescription: '24/7 Women\'s Safety Assistance',
    description: 'Immediate assistance and support for women\'s safety concerns.',
    phoneNumber: '1091',
    color: Colors.purple,
    icon: LineIcons.female,
    instructions: [
      'Stay in a safe location',
      'Speak clearly and calmly',
      'Share location details',
      'Document any evidence',
      'Keep emergency contacts ready',
      'Follow safety instructions',
    ],
  ),
  EmergencyService(
    title: 'Disaster Management',
    shortDescription: 'Natural Disaster Response',
    description: 'Emergency response and guidance during natural disasters.',
    phoneNumber: '1070',
    color: Colors.teal,
    icon: LineIcons.alternateCloudDownload,
    instructions: [
      'Stay in a safe location',
      'Follow official instructions',
      'Keep emergency supplies ready',
      'Help others if safe to do so',
      'Monitor official updates',
      'Evacuate if instructed',
    ],
  ),
];