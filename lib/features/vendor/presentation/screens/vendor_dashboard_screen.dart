import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VendorDashboardScreen extends StatefulWidget {
  const VendorDashboardScreen({super.key});

  @override
  State<VendorDashboardScreen> createState() => _VendorDashboardScreenState();
}

class _VendorDashboardScreenState extends State<VendorDashboardScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vendor Dashboard'),
        actions: [
          TextButton.icon(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool('isVendor', false);
              await prefs.setBool('isVendorPending', false);
              if (!mounted) return;
              Navigator.pushReplacementNamed(context, '/home');
            },
            icon: const Icon(LineIcons.user),
            label: const Text('User Mode'),
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          _HomeTab(),
          _OrdersTab(),
          _EarningsTab(),
          _ProfileTab(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(LineIcons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(LineIcons.clipboard),
            label: 'Orders',
          ),
          NavigationDestination(
            icon: Icon(LineIcons.wallet),
            label: 'Earnings',
          ),
          NavigationDestination(
            icon: Icon(LineIcons.user),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.orange[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Today\'s Earnings',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '₹2,450',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange[800],
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Icon(
                  LineIcons.indianRupeeSign,
                  color: Colors.orange[800],
                  size: 32,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Active Orders',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.orange[100],
                    child: const Icon(
                      LineIcons.tools,
                      color: Colors.orange,
                    ),
                  ),
                  title: Text('Order #${1001 + index}'),
                  subtitle: Text(
                    'Electronics Repair - ${[
                      "Laptop",
                      "Smartphone",
                      "TV"
                    ][index]}',
                  ),
                  trailing: Chip(
                    label: const Text('In Progress'),
                    backgroundColor: Colors.blue[50],
                    labelStyle: TextStyle(
                      color: Colors.blue[700],
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          const Text(
            'Performance',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  title: 'Rating',
                  value: '4.8',
                  icon: LineIcons.star,
                  color: Colors.amber,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard(
                  title: 'Jobs',
                  value: '156',
                  icon: LineIcons.checkCircle,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: color.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}

class _OrdersTab extends StatelessWidget {
  const _OrdersTab();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Active'),
              Tab(text: 'Completed'),
              Tab(text: 'Cancelled'),
              Tab(text: 'Pending'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildOrdersList('active'),
                _buildOrdersList('completed'),
                _buildOrdersList('cancelled'),
                _buildOrdersList('pending'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersList(String type) {
    final List<Map<String, String>> customers = [
      {'name': 'Rajesh Kumar', 'service': 'Laptop Repair'},
      {'name': 'Priya Sharma', 'service': 'AC Service'},
      {'name': 'Amit Patel', 'service': 'Plumbing Work'},
      {'name': 'Neha Gupta', 'service': 'House Cleaning'},
      {'name': 'Suresh Verma', 'service': 'TV Repair'},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order #${1001 + index}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (type == 'active')
                      DropdownButton<String>(
                        value: 'active',
                        items: const [
                          DropdownMenuItem(
                            value: 'active',
                            child: Text('Active'),
                          ),
                          DropdownMenuItem(
                            value: 'completed',
                            child: Text('Completed'),
                          ),
                          DropdownMenuItem(
                            value: 'cancelled',
                            child: Text('Cancelled'),
                          ),
                          DropdownMenuItem(
                            value: 'pending',
                            child: Text('Pending'),
                          ),
                        ],
                        onChanged: (value) {
                          // TODO: Implement status change
                        },
                      )
                    else
                      Chip(
                        label: Text(type.toUpperCase()),
                        backgroundColor: _getStatusColor(type),
                        labelStyle: const TextStyle(color: Colors.white),
                      ),
                  ],
                ),
                const Divider(),
                Text('Customer: ${customers[index]['name']}'),
                Text('Service: ${customers[index]['service']}'),
                const Text('Date: March 15, 2024'),
                const Text('Amount: ₹1,200'),
              ],
            ),
          ),
        );
      },
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'active':
        return Colors.blue;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      case 'pending':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}

class _EarningsTab extends StatelessWidget {
  const _EarningsTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.orange[400]!,
                  Colors.orange[300]!,
                ],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                const Text(
                  'Total Earnings',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '₹24,500',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildEarningsStat('This Week', '₹4,500'),
                    _buildEarningsStat('This Month', '₹18,000'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Recent Transactions',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green[50],
                  child: Icon(
                    LineIcons.indianRupeeSign,
                    color: Colors.green[700],
                  ),
                ),
                title: Text('Order #${1001 + index}'),
                subtitle: const Text('March 15, 2024'),
                trailing: Text(
                  '₹${800 + (index * 100)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEarningsStat(String title, String amount) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          amount,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _ProfileTab extends StatelessWidget {
  const _ProfileTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.orange,
              child: Icon(
                LineIcons.user,
                size: 50,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Center(
            child: Text(
              'Aravind Verma',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Center(
            child: Text(
              'Electronics Repair Specialist',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            'Business Information',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildInfoTile(
            icon: LineIcons.phone,
            title: 'Contact',
            subtitle: '+91 876 587 6509',
          ),
          _buildInfoTile(
            icon: LineIcons.envelope,
            title: 'Email',
            subtitle: 'aravind.verma@email.com',
          ),
          _buildInfoTile(
            icon: LineIcons.mapMarker,
            title: 'Address',
            subtitle: '123 Main Street, Bhopal, MP',
          ),
          const SizedBox(height: 32),
          const Text(
            'Account Settings',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildSettingsTile(
            icon: LineIcons.userEdit,
            title: 'Edit Profile',
            onTap: () {},
          ),
          _buildSettingsTile(
            icon: LineIcons.bell,
            title: 'Notifications',
            onTap: () {},
          ),
          _buildSettingsTile(
            icon: LineIcons.lock,
            title: 'Privacy & Security',
            onTap: () {},
          ),
          _buildSettingsTile(
            icon: LineIcons.wallet,
            title: 'Payment Settings',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.orange),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
