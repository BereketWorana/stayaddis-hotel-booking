import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/api_config.dart';
import '../config/app_theme.dart';

class AdminHotelsScreen extends StatefulWidget {
  const AdminHotelsScreen({super.key});

  @override
  State<AdminHotelsScreen> createState() => _AdminHotelsScreenState();
}

class _AdminHotelsScreenState extends State<AdminHotelsScreen> {
  List<dynamic> hotels = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchHotels();
  }

  Future<void> fetchHotels() async {
    final response = await http.get(Uri.parse('${ApiConfig.baseUrl}/api/admin/hotels'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() { hotels = data['data']; isLoading = false; });
    }
  }

  Future<void> _deleteHotel(id) async {
    await http.delete(Uri.parse('${ApiConfig.baseUrl}/api/admin/hotels/$id'));
    fetchHotels();
  }

  Future<void> _showHotelForm({dynamic hotel}) async {
    final nameCtrl = TextEditingController(text: hotel?['name'] ?? '');
    final descCtrl = TextEditingController(text: hotel?['description'] ?? '');
    final starsCtrl = TextEditingController(text: hotel?['star_rating']?.toString() ?? '3');
    final addrCtrl = TextEditingController(text: hotel?['address'] ?? '');
    final cityCtrl = TextEditingController(text: hotel?['city'] ?? 'Addis Ababa');
    final coverCtrl = TextEditingController(text: hotel?['cover_image'] ?? '');

    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(hotel == null ? 'Add Hotel' : 'Edit Hotel'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Name')),
              TextField(controller: descCtrl, decoration: const InputDecoration(labelText: 'Description'), maxLines: 3),
              TextField(controller: starsCtrl, decoration: const InputDecoration(labelText: 'Stars'), keyboardType: TextInputType.number),
              TextField(controller: addrCtrl, decoration: const InputDecoration(labelText: 'Address')),
              TextField(controller: cityCtrl, decoration: const InputDecoration(labelText: 'City')),
              TextField(controller: coverCtrl, decoration: const InputDecoration(labelText: 'Cover Image Path')),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              final body = {
                'name': nameCtrl.text, 'description': descCtrl.text,
                'star_rating': starsCtrl.text, 'address': addrCtrl.text,                'city': cityCtrl.text, 'cover_image': coverCtrl.text,
              };
              if (hotel == null) {
                await http.post(Uri.parse('${ApiConfig.baseUrl}/api/admin/hotels'), body: body);
              } else {
                await http.put(Uri.parse('${ApiConfig.baseUrl}/api/admin/hotels/${hotel['id']}'), body: body);
              }
              Navigator.pop(ctx);
              fetchHotels();
            },
            child: Text(hotel == null ? 'Add' : 'Update'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Hotels'), backgroundColor: AppColors.primary),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showHotelForm(),
        backgroundColor: AppColors.accent,
        child: const Icon(Icons.add),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: EdgeInsets.all(AppSpacing.md),
              itemCount: hotels.length,
              itemBuilder: (context, index) {
                final h = hotels[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(child: Text('${h['star_rating']}⭐')),
                    title: Text(h['name']),
                    subtitle: Text(h['address']),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(icon: const Icon(Icons.edit, color: Colors.blue), onPressed: () => _showHotelForm(hotel: h)),
                        IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => _deleteHotel(h['id'])),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
