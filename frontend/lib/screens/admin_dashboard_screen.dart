import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/api_config.dart';
import '../config/app_theme.dart';
import 'admin_hotels_screen.dart';
import 'admin_bookings_screen.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  Map<String, dynamic>? stats;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDashboard();
  }

  Future<void> fetchDashboard() async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/api/admin/dashboard'),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        stats = data['data'];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Dashboard'), backgroundColor: AppColors.primary),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _buildStatCard('Hotels', '${stats!['total_hotels']}', Icons.hotel, AppColors.primary),
                      SizedBox(width: AppSpacing.md),
                      _buildStatCard('Rooms', '${stats!['total_rooms']}', Icons.bed, AppColors.accent),
                    ],
                  ),
                  SizedBox(height: AppSpacing.md),
                  _buildStatCard('Bookings', '${stats!['total_bookings']}', Icons.book_online, Colors.green),
                  SizedBox(height: AppSpacing.lg),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminHotelsScreen())),
                      icon: const Icon(Icons.hotel),
                      label: const Text('Manage Hotels'),
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: AppColors.textOnPrimary, padding: EdgeInsets.all(AppSpacing.md)),
                    ),
                  ),
                  SizedBox(height: AppSpacing.md),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminBookingsScreen())),
                      icon: const Icon(Icons.book_online),
                      label: const Text('Manage Bookings'),
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent, foregroundColor: AppColors.textOnPrimary, padding: EdgeInsets.all(AppSpacing.md)),
                    ),
                  ),
                  SizedBox(height: AppSpacing.lg),
                  Text('Recent Bookings', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                  SizedBox(height: AppSpacing.sm),
                  SizedBox(
                    height: 250,
                    child: ListView.builder(
                      itemCount: (stats!['recent_bookings'] as List).length,
                      itemBuilder: (context, index) {
                        final b = stats!['recent_bookings'][index];
                        return ListTile(
                          title: Text(b['booking_reference']),
                          subtitle: Text('${b['check_in']} → ${b['check_out']} | ETB ${b['total_price']}'),
                          trailing: Container(
                            padding: EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 4),
                            decoration: BoxDecoration(
                              color: b['status'] == 'confirmed' ? Colors.green : Colors.orange,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(b['status'], style: const TextStyle(color: Colors.white, fontSize: 12)),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(AppSpacing.sm)),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            SizedBox(height: AppSpacing.sm),
            Text(value, style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: color)),
            Text(label, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
