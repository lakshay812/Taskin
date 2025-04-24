import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class BookedServicesScreen extends StatelessWidget {
  const BookedServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booked Services'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _mockBookings.length,
        itemBuilder: (context, index) {
          final booking = _mockBookings[index];
          return BookingCard(booking: booking);
        },
      ),
    );
  }
}

class BookingCard extends StatelessWidget {
  final Booking booking;

  const BookingCard({
    super.key,
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: booking.getStatusColor().withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    booking.getServiceIcon(),
                    color: booking.getStatusColor(),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking.serviceName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        booking.shopName,
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: booking.getStatusColor().withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    booking.status,
                    style: TextStyle(
                      color: booking.getStatusColor(),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Booking ID',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      booking.bookingId,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Date',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      booking.date,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (booking.status == 'Completed') ...[
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Book Again'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class Booking {
  final String serviceName;
  final String shopName;
  final String status;
  final String bookingId;
  final String date;

  const Booking({
    required this.serviceName,
    required this.shopName,
    required this.status,
    required this.bookingId,
    required this.date,
  });

  Color getStatusColor() {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'In Progress':
        return Colors.blue;
      case 'Completed':
        return Colors.green;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData getServiceIcon() {
    switch (serviceName) {
      case 'Electronics Repair':
        return LineIcons.tools;
      case 'Laundry':
        return LineIcons.tShirt;
      case 'Cleaning':
        return LineIcons.broom;
      case 'Plumbing':
        return LineIcons.shower;
      case 'AC Service':
        return LineIcons.snowflake;
      default:
        return LineIcons.wrench;
    }
  }
}

final List<Booking> _mockBookings = [
  Booking(
    serviceName: 'Electronics Repair',
    shopName: 'Kirti Electronics Solutions',
    status: 'Completed',
    bookingId: 'ER001',
    date: '15 Mar 2024',
  ),
  Booking(
    serviceName: 'Laundry',
    shopName: 'Chawala Pristine Laundry',
    status: 'In Progress',
    bookingId: 'LD002',
    date: '18 Mar 2024',
  ),
  Booking(
    serviceName: 'Cleaning',
    shopName: 'Nirmal Cleaning Solutions',
    status: 'Pending',
    bookingId: 'CL003',
    date: '20 Mar 2024',
  ),
  Booking(
    serviceName: 'AC Service',
    shopName: 'Thanda Solutions',
    status: 'Cancelled',
    bookingId: 'AC004',
    date: '12 Mar 2024',
  ),
];