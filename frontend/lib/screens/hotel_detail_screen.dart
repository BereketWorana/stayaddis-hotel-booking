import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/api_config.dart';
import '../config/app_theme.dart';
import 'booking_screen.dart';

class HotelDetailScreen extends StatefulWidget {
  final dynamic hotel;
  final Map<String, dynamic>? user;

  const HotelDetailScreen({super.key, required this.hotel, this.user});

  @override
  State<HotelDetailScreen> createState() => _HotelDetailScreenState();
}

class _HotelDetailScreenState extends State<HotelDetailScreen> {
  dynamic hotelDetail;
  List<dynamic> rooms = [];
  List<dynamic> gallery = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchHotelDetail();
  }

  Future<void> fetchHotelDetail() async {
    final response = await http.get(Uri.parse(ApiConfig.hotelDetailEndpoint(widget.hotel['id'])));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        hotelDetail = data['data']['hotel'];
        rooms = data['data']['rooms'];
        gallery = data['data']['gallery'];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 300,
                  pinned: true,
                  backgroundColor: AppColors.primary,
                  flexibleSpace: FlexibleSpaceBar(
                    background: gallery.isNotEmpty
                        ? PageView.builder(
                            itemCount: gallery.length,
                            itemBuilder: (context, index) => Hero(
                              tag: 'hotel-${hotelDetail['id']}',
                              child: Image.network(
                                ApiConfig.imageUrl(gallery[index]['image_path']),
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(color: Colors.grey[300]),
                              ),
                            ),
                          )
                        : Container(color: Colors.grey[300]),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [AppColors.primary, Color(0xFFF5F5F5)],
                        stops: [0.0, 0.25],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.md, AppSpacing.lg, AppSpacing.xl),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Row(children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(mainAxisSize: MainAxisSize.min, children: [
                              const Icon(Icons.star, size: 14, color: Colors.amber),
                              const SizedBox(width: 4),
                              Text('${hotelDetail['star_rating']}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 14)),
                            ]),
                          ),
                        ]),
                        const SizedBox(height: AppSpacing.md),
                        Text(hotelDetail['name'], style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.white, height: 1.2)),
                        const SizedBox(height: AppSpacing.xs),
                        Row(children: [
                          const Icon(Icons.location_on, size: 16, color: Colors.white70),
                          const SizedBox(width: 4),
                          Expanded(child: Text(hotelDetail['address'] ?? '', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70))),
                        ]),
                        const SizedBox(height: AppSpacing.lg),
                        Text('Available Rooms', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                        const SizedBox(height: AppSpacing.md),
                        ...rooms.map((room) => _buildRoomCard(room)),
                      ]),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildRoomCard(dynamic room) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 16, offset: const Offset(0, 6))],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => BookingScreen(room: room, hotel: hotelDetail, user: widget.user))),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.network(ApiConfig.imageUrl(room['image']), width: 90, height: 90, fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(width: 90, height: 90, decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(14)), child: const Icon(Icons.bed, color: Colors.grey, size: 32))),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(room['room_type'], style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                const SizedBox(height: 4),
                Text(room['description'] ?? '', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary), maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: AppSpacing.sm),
                Row(children: [
                  _chip(Icons.person_outline, '${room['capacity']}'),
                  const SizedBox(width: AppSpacing.sm),
                  _chip(Icons.meeting_room_outlined, '${room['available_count']}'),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(gradient: const LinearGradient(colors: [AppColors.accent, Color(0xFFFF6B81)]), borderRadius: BorderRadius.circular(12)),
                    child: Text('ETB ${double.parse(room['price_per_night'].toString()).toStringAsFixed(0)}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                  ),
                ]),
              ])),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _chip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(16)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 13, color: AppColors.textSecondary),
        const SizedBox(width: 3),
        Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
      ]),
    );
  }
}
