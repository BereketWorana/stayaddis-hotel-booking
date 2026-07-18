import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/api_config.dart';
import '../config/app_theme.dart';
import 'booking_screen.dart';


class HotelDetailScreen extends StatefulWidget {
  final dynamic hotel;

  const HotelDetailScreen({super.key, required this.hotel});

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
    final response = await http.get(
      Uri.parse(ApiConfig.hotelDetailEndpoint(widget.hotel['id'])),
    );

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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 280,
                  pinned: true,
                  backgroundColor: AppColors.primary,
                  flexibleSpace: FlexibleSpaceBar(
                    background: gallery.isNotEmpty
                        ? PageView.builder(
                            itemCount: gallery.length,
                            itemBuilder: (context, index) {
                              return Image.network(
                                ApiConfig.imageUrl(
                                    gallery[index]['image_path']),
                                fit: BoxFit.cover,
                                errorBuilder: (_, _, _) => Container(
                                  color: Colors.grey[300],
                                ),
                              );
                            },
                          )
                        : Container(color: Colors.grey[300]),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Star rating badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.sm,
                            vertical: AppSpacing.xs,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.accent,
                            borderRadius: BorderRadius.circular(AppSpacing.lg),
                          ),
                          child: Text(
                            '${List.filled(int.parse(hotelDetail['star_rating'].toString()), '⭐').join()} ${hotelDetail['star_rating']} Stars',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(color: AppColors.textOnPrimary),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),

                        // Hotel name
                        Text(
                          hotelDetail['name'],
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                        ),
                        const SizedBox(height: AppSpacing.sm),

                        // Address
                        Row(
                          children: [
                            const Icon(Icons.location_on,
                                size: 16, color: AppColors.textSecondary),
                            const SizedBox(width: AppSpacing.xs),
                            Text(
                              hotelDetail['address'],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.md),

                        // Description
                        Text(
                          hotelDetail['description'],
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.textSecondary,
                                height: 1.5,
                              ),
                        ),
                        const SizedBox(height: AppSpacing.lg),

                        // Rooms heading
                        Text(
                          'Available Rooms',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                        ),
                        const SizedBox(height: AppSpacing.md),

                        // Room cards
                        ...rooms.map((room) => _buildRoomCard(room)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildRoomCard(dynamic room) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.sm),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.sm),
            child: Image.network(
              ApiConfig.imageUrl(room['image']),
              width: 72,
              height: 72,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                width: 72,
                height: 72,
                color: Colors.grey[100],
                child:
                    const Icon(Icons.bed, color: Colors.grey, size: 28),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  room['room_type'],
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  room['description'],
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppSpacing.xs),
                
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'ETB ${double.parse(room['price_per_night']).toStringAsFixed(0)}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.accent,
                    ),
              ),
                            Text(
                '/night',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
              const SizedBox(height: AppSpacing.sm),
              SizedBox(
                width: 90,
                height: 34,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookingScreen(
                          room: room,
                          hotel: hotelDetail,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    foregroundColor: AppColors.textOnPrimary,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSpacing.sm)),
                  ),
                  child: const Text('Book', style: TextStyle(fontSize: 13)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
              
              
  }
}