import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/api_config.dart';
import '../config/app_theme.dart';
import 'confirmation_screen.dart';

class BookingScreen extends StatefulWidget {
  final dynamic room;
  final dynamic hotel;

  const BookingScreen({super.key, required this.room, required this.hotel});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  DateTime _checkIn = DateTime.now().add(const Duration(days: 1));
  DateTime _checkOut = DateTime.now().add(const Duration(days: 3));
  int _guests = 2;
  bool _isLoading = false;
  String _paymentMethod = 'cash';

  int get _nights => _checkOut.difference(_checkIn).inDays;
  double get _totalPrice =>
      double.parse(widget.room['price_per_night'].toString()) * _nights;

  Future<void> _pickDate(bool isCheckIn) async {
    final date = await showDatePicker(
      context: context,
      initialDate: isCheckIn ? _checkIn : _checkOut,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      setState(() {
        if (isCheckIn) {
          _checkIn = date;
          if (_checkOut.isBefore(_checkIn.add(const Duration(days: 1)))) {
            _checkOut = _checkIn.add(const Duration(days: 1));
          }
        } else {
          _checkOut = date;
        }
      });
    }
  }

  Future<void> _submitBooking() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/api/bookings'),
      body: {
        'room_id': widget.room['id'].toString(),
        'check_in': _checkIn.toString().split(' ')[0],
        'check_out': _checkOut.toString().split(' ')[0],
        'guests': _guests.toString(),
        'full_name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'phone': _phoneController.text.trim(),
        'payment_method': _paymentMethod,
      },
    );

    setState(() => _isLoading = false);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ConfirmationScreen(
            booking: data['data'],
            hotel: widget.hotel,
            room: widget.room,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Booking failed. Please try again.')),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Room'),
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                    Text(widget.hotel['name'],
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                    SizedBox(height: AppSpacing.xs),
                    Text(widget.room['room_type'],
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary)),
                  ],
                ),
              ),
              SizedBox(height: AppSpacing.lg),
              Text('Select Dates',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
              SizedBox(height: AppSpacing.sm),
              Row(children: [
                Expanded(child: _buildDateButton('Check-in', _checkIn, () => _pickDate(true))),
                SizedBox(width: AppSpacing.md),
                Expanded(child: _buildDateButton('Check-out', _checkOut, () => _pickDate(false))),
              ]),
              SizedBox(height: AppSpacing.lg),
              Text('Guests',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
              SizedBox(height: AppSpacing.sm),
              Row(children: [
                IconButton(
                    onPressed: _guests > 1 ? () => setState(() => _guests--) : null,
                    icon: const Icon(Icons.remove_circle_outline)),
                Text('$_guests', style: Theme.of(context).textTheme.titleLarge),
                IconButton(
                    onPressed: _guests < int.parse(widget.room['capacity'].toString())
                        ? () => setState(() => _guests++)
                        : null,
                    icon: const Icon(Icons.add_circle_outline)),
              ]),
              SizedBox(height: AppSpacing.lg),
              Text('Your Details',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
              SizedBox(height: AppSpacing.sm),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                    labelText: 'Full Name', border: OutlineInputBorder(), prefixIcon: Icon(Icons.person)),
                validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
              ),
              SizedBox(height: AppSpacing.md),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                    labelText: 'Email', border: OutlineInputBorder(), prefixIcon: Icon(Icons.email)),
                keyboardType: TextInputType.emailAddress,
                validator: (v) => v == null || !v.contains('@') ? 'Valid email required' : null,
              ),
              SizedBox(height: AppSpacing.md),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                    labelText: 'Phone', border: OutlineInputBorder(), prefixIcon: Icon(Icons.phone)),
                keyboardType: TextInputType.phone,
                validator: (v) => v == null || v.trim().length < 10 ? 'Valid phone required' : null,
              ),
                SizedBox(height: AppSpacing.lg),
Text('Payment Method',
    style: Theme.of(context).textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
SizedBox(height: AppSpacing.sm),
DropdownButtonFormField<String>(
  value: _paymentMethod,
  decoration: const InputDecoration(
    border: OutlineInputBorder(),
    prefixIcon: Icon(Icons.payment),
  ),
  items: const [
    DropdownMenuItem(value: 'cash', child: Text('Cash on Arrival')),
    DropdownMenuItem(value: 'telebirr', child: Text('TeleBirr')),
    DropdownMenuItem(value: 'cbe_birr', child: Text('CBE Birr')),
    DropdownMenuItem(value: 'visa', child: Text('Visa Card')),
    DropdownMenuItem(value: 'mastercard', child: Text('Mastercard')),
    DropdownMenuItem(value: 'amex', child: Text('American Express')),
  ],
  onChanged: (value) {
    setState(() {
      _paymentMethod = value!;
    });
  },
),
              SizedBox(height: AppSpacing.lg),
              Container(
                padding: EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(AppSpacing.md)),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('$_nights nights', style: Theme.of(context).textTheme.bodyMedium),
                    Text('ETB ${double.parse(widget.room['price_per_night'].toString()).toStringAsFixed(0)}/night',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary)),
                  ]),
                  Text('ETB ${_totalPrice.toStringAsFixed(0)}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold, color: AppColors.accent)),
                ]),
              ),
              SizedBox(height: AppSpacing.lg),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitBooking,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accent,
                      foregroundColor: AppColors.textOnPrimary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.sm))),
                  child: _isLoading
                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                      : const Text('Confirm Booking', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateButton(String label, DateTime date, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(AppSpacing.sm)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label, style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.textSecondary)),
          SizedBox(height: AppSpacing.xs),
          Text('${date.day}/${date.month}/${date.year}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
        ]),
      ),
    );
  }
}
