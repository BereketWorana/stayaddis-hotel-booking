import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/api_config.dart';
import '../config/app_theme.dart';

class MyBookingsScreen extends StatefulWidget {
  final Map<String, dynamic> user;
  const MyBookingsScreen({super.key, required this.user});

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  List<dynamic> bookings = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBookings();
  }

  Future<void> fetchBookings() async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/api/my-bookings?user_id=${widget.user['id']}'),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        bookings = data['data'] ?? [];
        isLoading = false;
      });
    } else {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Bookings'), backgroundColor: AppColors.primary),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : bookings.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.book_online, size: 64, color: Colors.grey),
                      SizedBox(height: AppSpacing.md),
                      Text('No bookings yet', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.grey)),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.all(AppSpacing.md),
                  itemCount: bookings.length,
                  itemBuilder: (context, index) {
                    final b = bookings[index];
                    return Card(
                      child: Padding(
                        padding: EdgeInsets.all(AppSpacing.md),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(b['booking_reference'],
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: b['status'] == 'confirmed' ? Colors.green : b['status'] == 'cancelled' ? Colors.red : Colors.orange,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(b['status'], style: const TextStyle(color: Colors.white, fontSize: 12)),
                                ),
                              ],
                            ),
                            SizedBox(height: AppSpacing.sm),
                            Text('${b['hotel_name']} - ${b['room_type']}'),
                            Text('${b['check_in']} → ${b['check_out']} | ${b['guests']} guests'),
                            SizedBox(height: AppSpacing.xs),
                            Text('ETB ${b['total_price']}',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.accent, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
