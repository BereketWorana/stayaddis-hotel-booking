import 'package:flutter/material.dart';
import '../config/app_theme.dart';

class ConfirmationScreen extends StatelessWidget {
  final dynamic booking;
  final dynamic hotel;
  final dynamic room;

  const ConfirmationScreen({
    super.key,
    required this.booking,
    required this.hotel,
    required this.room,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Confirmed'),
        backgroundColor: AppColors.primary,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(milliseconds: 800),
              curve: Curves.elasticOut,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: const Icon(Icons.check_circle, size: 80, color: Colors.green),
                );
              },
            ),
              SizedBox(height: AppSpacing.lg),
              Text('Booking Confirmed!',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
              SizedBox(height: AppSpacing.sm),
              Text('Your booking reference',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary)),
              SizedBox(height: AppSpacing.sm),
              Container(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
                decoration: BoxDecoration(
                    color: AppColors.primary, borderRadius: BorderRadius.circular(AppSpacing.sm)),
                child: Text(booking['booking_reference'],
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AppColors.textOnPrimary, fontWeight: FontWeight.bold, letterSpacing: 2)),
              ),
              SizedBox(height: AppSpacing.xl),
              _row(context, 'Hotel', hotel['name']),
              _row(context, 'Room', room['room_type']),
              _row(context, 'Check-in', booking['check_in']),
              _row(context, 'Check-out', booking['check_out']),
              _row(context, 'Guests', '${booking['guests']}'),
              _row(context, 'Total', 'ETB ${double.parse(booking['total_price'].toString()).toStringAsFixed(0)}'),
              _row(context, 'Payment', booking['payment_method'] ?? 'Cash on Arrival'),
              _row(context, 'Status', 'Confirmed ✅'),
              SizedBox(height: AppSpacing.xl),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accent,
                      foregroundColor: AppColors.textOnPrimary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.sm))),
                  child: const Text('Back to Home', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _row(BuildContext context, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary)),
        Text(value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
      ]),
    );
  }
}
