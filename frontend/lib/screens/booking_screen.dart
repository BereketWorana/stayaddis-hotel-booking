import 'package:flutter/material.dart';
import '../config/app_theme.dart';
import 'payment_screen.dart';

class BookingScreen extends StatefulWidget {
  final dynamic room;
  final dynamic hotel;
  final Map<String, dynamic>? user;

  const BookingScreen({super.key, required this.room, required this.hotel, this.user});

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

  int get _nights => _checkOut.difference(_checkIn).inDays;
  double get _totalPrice =>
      double.parse(widget.room['price_per_night'].toString()) * _nights;

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      _nameController.text = widget.user!['full_name'] ?? '';
      _emailController.text = widget.user!['email'] ?? '';
      _phoneController.text = widget.user!['phone'] ?? '';
    }
  }

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

  void _goToPayment() {
    if (!_formKey.currentState!.validate()) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PaymentScreen(
          hotel: widget.hotel,
          room: widget.room,
          checkIn: _checkIn.toString().split(' ')[0],
          checkOut: _checkOut.toString().split(' ')[0],
          guests: _guests,
          fullName: widget.user?['full_name'] ?? _nameController.text.trim(),
          email: widget.user?['email'] ?? _emailController.text.trim(),
          phone: widget.user?['phone'] ?? _phoneController.text.trim(),
        ),
      ),
    );
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
    final isLoggedIn = widget.user != null;
    return Scaffold(
      appBar: AppBar(title: const Text('Book Room'), backgroundColor: AppColors.primary),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Form(
          key: _formKey,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              padding: EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppSpacing.md), border: Border.all(color: Colors.grey.shade200)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(widget.hotel['name'], style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                SizedBox(height: AppSpacing.xs),
                Text(widget.room['room_type'], style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary)),
              ]),
            ),
            SizedBox(height: AppSpacing.lg),
            Text('Select Dates', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
            SizedBox(height: AppSpacing.sm),
            Row(children: [
              Expanded(child: _buildDateButton('Check-in', _checkIn, () => _pickDate(true))),
              SizedBox(width: AppSpacing.md),
              Expanded(child: _buildDateButton('Check-out', _checkOut, () => _pickDate(false))),
            ]),
            SizedBox(height: AppSpacing.lg),
            Text('Guests', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
            SizedBox(height: AppSpacing.sm),
            Row(children: [
              IconButton(onPressed: _guests > 1 ? () => setState(() => _guests--) : null, icon: const Icon(Icons.remove_circle_outline)),
              Text('$_guests', style: Theme.of(context).textTheme.titleLarge),
              IconButton(onPressed: _guests < int.parse(widget.room['capacity'].toString()) ? () => setState(() => _guests++) : null, icon: const Icon(Icons.add_circle_outline)),
            ]),
            if (!isLoggedIn) ...[
              SizedBox(height: AppSpacing.lg),
              Text('Your Details', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
              SizedBox(height: AppSpacing.sm),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Full Name', border: OutlineInputBorder(), prefixIcon: Icon(Icons.person)),
                validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
              ),
              SizedBox(height: AppSpacing.md),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder(), prefixIcon: Icon(Icons.email)),
                keyboardType: TextInputType.emailAddress,
                validator: (v) => v == null || !v.contains('@') ? 'Valid email required' : null,
              ),
              SizedBox(height: AppSpacing.md),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone', border: OutlineInputBorder(), prefixIcon: Icon(Icons.phone)),
                keyboardType: TextInputType.phone,
                validator: (v) => v == null || v.trim().length < 10 ? 'Valid phone required' : null,
              ),
            ],
            SizedBox(height: AppSpacing.lg),
            Container(
              padding: EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(AppSpacing.md)),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('$_nights nights', style: Theme.of(context).textTheme.bodyMedium),
                  Text('ETB ${double.parse(widget.room['price_per_night'].toString()).toStringAsFixed(0)}/night',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary)),
                ]),
                Text('ETB ${_totalPrice.toStringAsFixed(0)}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: AppColors.accent)),
              ]),
            ),
            SizedBox(height: AppSpacing.lg),
            SizedBox(
              width: double.infinity, height: 52,
              child: ElevatedButton(
                onPressed: _goToPayment,
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent, foregroundColor: AppColors.textOnPrimary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.sm))),
                child: const Text('Continue to Payment', style: TextStyle(fontSize: 16)),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _buildDateButton(String label, DateTime date, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(AppSpacing.sm)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label, style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.textSecondary)),
          SizedBox(height: AppSpacing.xs),
          Text('${date.day}/${date.month}/${date.year}', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
        ]),
      ),
    );
  }
}
