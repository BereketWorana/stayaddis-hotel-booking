import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/api_config.dart';
import '../config/app_theme.dart';

class AdminBookingsScreen extends StatefulWidget {
  const AdminBookingsScreen({super.key});

  @override
  State<AdminBookingsScreen> createState() => _AdminBookingsScreenState();
}

class _AdminBookingsScreenState extends State<AdminBookingsScreen> {
  List<dynamic> bookings = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBookings();
  }

  Future<void> fetchBookings() async {
    final response = await http.get(Uri.parse('${ApiConfig.baseUrl}/api/admin/bookings'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() { bookings = data['data']; isLoading = false; });
    }
  }

  Future<void> _updateStatus(id, status) async {
    await http.put(
      Uri.parse('${ApiConfig.baseUrl}/api/admin/bookings/$id/status'),
      body: {'status': status},
    );
    fetchBookings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Bookings'), backgroundColor: AppColors.primary),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: EdgeInsets.all(AppSpacing.md),
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                final b = bookings[index];
                return Card(
                  child: ListTile(
                    title: Text('${b['booking_reference']} - ${b['full_name']}'),
                    subtitle: Text('${b['hotel_name']} | ${b['room_type']} | ${b['check_in']} → ${b['check_out']}\nETB ${b['total_price']}'),
                    trailing: PopupMenuButton<String>(
                      onSelected: (status) => _updateStatus(b['id'], status),
                      itemBuilder: (_) => [
                        const PopupMenuItem(value: 'confirmed', child: Text('Confirm')),
                        const PopupMenuItem(value: 'cancelled', child: Text('Cancel')),
                      ],
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 4),
                        decoration: BoxDecoration(
                          color: b['status'] == 'confirmed' ? Colors.green : Colors.orange,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(b['status'], style: const TextStyle(color: Colors.white, fontSize: 12)),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
