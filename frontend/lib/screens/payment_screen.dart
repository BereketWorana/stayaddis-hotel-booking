import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/api_config.dart';
import '../config/app_theme.dart';
import 'confirmation_screen.dart';

class PaymentScreen extends StatefulWidget {
  final dynamic hotel;
  final dynamic room;
  final String checkIn;
  final String checkOut;
  final int guests;
  final String fullName;
  final String email;
  final String phone;

  const PaymentScreen({
    super.key,
    required this.hotel,
    required this.room,
    required this.checkIn,
    required this.checkOut,
    required this.guests,
    required this.fullName,
    required this.email,
    required this.phone,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _selectedMethod = 'cash';
  bool _isProcessing = false;

  int get _nights {
    final inDate = DateTime.parse(widget.checkIn);
    final outDate = DateTime.parse(widget.checkOut);
    return outDate.difference(inDate).inDays;
  }

  double get _totalPrice =>
      double.parse(widget.room['price_per_night'].toString()) * _nights;

  Future<void> _pay() async {
    setState(() => _isProcessing = true);

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/api/bookings'),
      body: {
        'room_id': widget.room['id'].toString(),
        'check_in': widget.checkIn,
        'check_out': widget.checkOut,
        'guests': widget.guests.toString(),
        'full_name': widget.fullName,
        'email': widget.email,
        'phone': widget.phone,
        'payment_method': _selectedMethod,
      },
    );

    if (!mounted) return;

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ConfirmationScreen(
            booking: data['data'],
            hotel: widget.hotel,
            room: widget.room,
          ),
        ),
      );
    } else {
      setState(() => _isProcessing = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Payment failed. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        backgroundColor: AppColors.primary,
      ),
      body: _isProcessing
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  SizedBox(height: AppSpacing.lg),
                  Text('Processing payment...',
                      style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Order Summary Card
                  Container(
                    padding: EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(AppSpacing.md),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Order Summary',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                        SizedBox(height: AppSpacing.md),
                        _summaryRow('Hotel', widget.hotel['name']),
                        _summaryRow('Room', widget.room['room_type']),
                        _summaryRow('Check-in', widget.checkIn),
                        _summaryRow('Check-out', widget.checkOut),
                        _summaryRow('Nights', '$_nights'),
                        _summaryRow('Guests', '${widget.guests}'),
                        Divider(height: AppSpacing.lg),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold)),
                            Text('ETB ${_totalPrice.toStringAsFixed(0)}',
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold, color: AppColors.accent)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppSpacing.lg),

                  // Payment Method Selection
                  Text('Select Payment Method',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                  SizedBox(height: AppSpacing.md),
                  _paymentOption('cash', 'Cash on Arrival', Icons.money),
                  _paymentOption('telebirr', 'TeleBirr', Icons.phone_android),
                  _paymentOption('cbe_birr', 'CBE Birr', Icons.account_balance),
                  _paymentOption('visa', 'Visa Card', Icons.credit_card),
                  _paymentOption('mastercard', 'Mastercard', Icons.credit_card),
                  _paymentOption('amex', 'American Express', Icons.credit_card),
                  SizedBox(height: AppSpacing.lg),

                  // Pay Button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _pay,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        foregroundColor: AppColors.textOnPrimary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppSpacing.sm)),
                      ),
                      child: Text(
                        'Pay ETB ${_totalPrice.toStringAsFixed(0)}',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _summaryRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary)),
          Text(value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        ],
      ),
    );
  }

  Widget _paymentOption(String value, String label, IconData icon) {
    final isSelected = _selectedMethod == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedMethod = value),
      child: Container(
        margin: EdgeInsets.only(bottom: AppSpacing.sm),
        padding: EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.accent.withValues(alpha: 0.1) : AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.sm),
          border: Border.all(
            color: isSelected ? AppColors.accent : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? AppColors.accent : AppColors.textSecondary),
            SizedBox(width: AppSpacing.md),
            Text(label,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? AppColors.accent : AppColors.textPrimary)),
            const Spacer(),
            if (isSelected)
              const Icon(Icons.check_circle, color: AppColors.accent),
          ],
        ),
      ),
    );
  }
}
