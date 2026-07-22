import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/api_config.dart';
import '../config/app_theme.dart';

class LookupScreen extends StatefulWidget {
  const LookupScreen({super.key});

  @override
  State<LookupScreen> createState() => _LookupScreenState();
}

class _LookupScreenState extends State<LookupScreen> {
  final _refController = TextEditingController();
  final _emailController = TextEditingController();
  dynamic _result;
  String? _error;
  bool _loading = false;

  Future<void> _lookup() async {
    setState(() { _loading = true; _error = null; _result = null; });
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/api/bookings/lookup?ref=${_refController.text.trim()}&email=${_emailController.text.trim()}'),
    );
    final data = json.decode(response.body);
    setState(() {
      _loading = false;
      if (response.statusCode == 200) {
        _result = data['data'];
      } else {
        _error = data['message'] ?? 'Booking not found';
      }
    });
  }

  @override
  void dispose() {
    _refController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Find My Booking'), backgroundColor: AppColors.primary),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.lg),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Icon(Icons.search, size: 48, color: AppColors.primary),
          SizedBox(height: AppSpacing.md),
          Text('Enter your booking details', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          SizedBox(height: AppSpacing.xs),
          Text('Check your confirmation email for the reference number', style: TextStyle(color: AppColors.textSecondary)),
          SizedBox(height: AppSpacing.lg),
          TextField(
            controller: _refController,
            decoration: const InputDecoration(labelText: 'Booking Reference', hintText: 'SAD-XXXX', border: OutlineInputBorder(), prefixIcon: Icon(Icons.tag)),
          ),
          SizedBox(height: AppSpacing.md),
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder(), prefixIcon: Icon(Icons.email)),
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: AppSpacing.lg),
          SizedBox(
            width: double.infinity, height: 52,
            child: ElevatedButton(
              onPressed: _loading ? null : _lookup,
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent, foregroundColor: AppColors.textOnPrimary),
              child: _loading ? const CircularProgressIndicator(color: Colors.white) : const Text('Look Up', style: TextStyle(fontSize: 16)),
            ),
          ),
          if (_error != null) ...[
            SizedBox(height: AppSpacing.lg),
            Container(
              padding: EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(12)),
              child: Row(children: [
                const Icon(Icons.error_outline, color: Colors.red),
                SizedBox(width: AppSpacing.sm),
                Expanded(child: Text(_error!, style: const TextStyle(color: Colors.red))),
              ]),
            ),
          ],
          if (_result != null) ...[
            SizedBox(height: AppSpacing.lg),
            Container(
              padding: EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.green.shade200)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 24),
                  SizedBox(width: AppSpacing.sm),
                  Text('Booking Found!', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.green)),
                ]),
                const Divider(height: 24),
                _row('Reference', _result['booking_reference']),
                _row('Hotel', _result['hotel_name']),
                _row('Room', _result['room_type']),
                _row('Check-in', _result['check_in']),
                _row('Check-out', _result['check_out']),
                _row('Guests', '${_result['guests']}'),
                _row('Total', 'ETB ${_result['total_price']}'),
                _row('Status', _result['status']),
              ]),
            ),
          ],
        ]),
      ),
    );
  }

  Widget _row(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label, style: const TextStyle(color: AppColors.textSecondary)),
        Text('$value', style: const TextStyle(fontWeight: FontWeight.w600)),
      ]),
    );
  }
}
