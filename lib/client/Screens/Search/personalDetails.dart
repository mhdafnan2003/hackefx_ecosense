import 'package:flutter/material.dart';

class PersonalVehicleDetails extends StatelessWidget {
  const PersonalVehicleDetails({super.key});

  // Define your color theme
  final Color primaryColor = const Color(0xFF1C1D21);
  final Color secondaryColor = const Color(0xFF17CF96);
  final Color textColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Profile Section
            _buildSectionHeader('Personal Information'),
            _buildDetailCard(
              icon: Icons.person,
              title: 'Name',
              value: 'Amal',
            ),
            _buildDetailCard(
              icon: Icons.phone,
              title: 'Contact',
              value: '+91 89439 41337',
            ),
            _buildDetailCard(
              icon: Icons.email,
              title: 'Email',
              value: 'amal69@gmail.com',
            ),
            
            const SizedBox(height: 30),
            
            // Vehicle Section
            _buildSectionHeader('Vehicle Information'),
            _buildDetailCard(
              icon: Icons.directions_car,
              title: 'Vehicle Name',
              value: 'Tesla Model 3',
            ),
            _buildDetailCard(
              icon: Icons.model_training,
              title: 'Model',
              value: '2023 Long Range',
            ),
            _buildDetailCard(
              icon: Icons.confirmation_number,
              title: 'License Plate',
              value: 'KL 07 X 069',
            ),
            _buildDetailCard(
              icon: Icons.color_lens,
              title: 'Color',
              value: 'Midnight Silver',
            ),
            
            const SizedBox(height: 40),
            
            // Edit Button
            ElevatedButton(
              onPressed: () {
                // Add edit functionality
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Edit Details',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              color: secondaryColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Expanded(
            child: Divider(
              color: Colors.grey,
              thickness: 1,
              indent: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      color: primaryColor.withOpacity(0.7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.grey.shade800, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Icon(icon, color: secondaryColor, size: 24),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  value,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}