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
      setState(() { bookings = data['data'] ?? []; isLoading = false; });
    } else {
      setState(() => isLoading = false);
    }
  }

  Future<void> _cancelBooking(dynamic booking) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Cancel Booking'),
        content: Text('Cancel ${booking['booking_reference']}?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('No')),
          ElevatedButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Yes, Cancel')),
        ],
      ),
    );
    if (confirm == true) {
      await http.put(
        Uri.parse('${ApiConfig.baseUrl}/api/admin/bookings/${booking['id']}/status'),
        body: {'status': 'cancelled'},
      );
      fetchBookings();
    }
  }

  void _showDetail(dynamic b) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(
            child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2))),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(b['booking_reference'], style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: AppSpacing.lg),
          _detailRow('Hotel', b['hotel_name'] ?? 'N/A'),
          _detailRow('Room', b['room_type'] ?? 'N/A'),
          _detailRow('Check-in', b['check_in'] ?? ''),
          _detailRow('Check-out', b['check_out'] ?? ''),
          _detailRow('Guests', '${b['guests']}'),
          _detailRow('Total', 'ETB ${b['total_price']}'),
          _detailRow('Payment', b['payment_method'] ?? 'Cash'),
          _detailRow('Status', b['status'] ?? ''),
          const SizedBox(height: AppSpacing.lg),
        ]),
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label, style: const TextStyle(color: AppColors.textSecondary)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Bookings'), backgroundColor: AppColors.primary),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : bookings.isEmpty
              ? Center(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Icon(Icons.book_online, size: 64, color: Colors.grey),
                    SizedBox(height: AppSpacing.md),
                    Text('No bookings yet', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.grey)),
                    SizedBox(height: AppSpacing.sm),
                    Text('Your bookings will appear here', style: TextStyle(color: Colors.grey[500])),
                  ]),
                )
              : RefreshIndicator(
                  onRefresh: fetchBookings,
                  child: ListView.builder(
                    padding: EdgeInsets.all(AppSpacing.md),
                    itemCount: bookings.length,
                    itemBuilder: (context, index) {
                      final b = bookings[index];
                      final isCancelled = b['status'] == 'cancelled';
                      return GestureDetector(
                        onTap: () => _showDetail(b),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: AppSpacing.md),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: isCancelled ? Colors.red.shade200 : Colors.grey.shade200),
                            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 10, offset: const Offset(0, 4))],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(AppSpacing.md),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                Text(b['booking_reference'], style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: isCancelled ? Colors.red.shade50 : b['status'] == 'confirmed' ? Colors.green.shade50 : Colors.orange.shade50,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(b['status'] ?? '', style: TextStyle(
                                    color: isCancelled ? Colors.red : b['status'] == 'confirmed' ? Colors.green : Colors.orange,
                                    fontSize: 12, fontWeight: FontWeight.w600,
                                  )),
                                ),
                              ]),
                              const SizedBox(height: AppSpacing.sm),
                              Text('${b['hotel_name'] ?? 'Hotel'} — ${b['room_type'] ?? 'Room'}', style: Theme.of(context).textTheme.bodyMedium),
                              const SizedBox(height: 4),
                              Text('${b['check_in']} → ${b['check_out']} • ${b['guests']} guests', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary)),
                              const SizedBox(height: AppSpacing.sm),
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                Text('ETB ${b['total_price']}', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.accent, fontWeight: FontWeight.bold)),
                                if (!isCancelled && b['status'] != 'completed')
                                  TextButton.icon(
                                    onPressed: () => _cancelBooking(b),
                                    icon: const Icon(Icons.cancel_outlined, size: 18, color: Colors.red),
                                    label: const Text('Cancel', style: TextStyle(color: Colors.red, fontSize: 13)),
                                  ),
                              ]),
                            ]),
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
