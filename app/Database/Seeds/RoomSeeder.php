<?php

namespace App\Database\Seeds;

use CodeIgniter\Database\Seeder;

class RoomSeeder extends Seeder
{
    public function run()
    {
        $data = [
            // Skylight Hotel (id=1)
            ['hotel_id' => 1, 'room_type' => 'Standard Room', 'description' => 'Comfortable room with city view', 'price_per_night' => 3500.00, 'capacity' => 2, 'available_count' => 20, 'image' => 'rooms/skylight/standard_room.jpg'],
            ['hotel_id' => 1, 'room_type' => 'Executive Suite', 'description' => 'Luxury suite with separate living area', 'price_per_night' => 12000.00, 'capacity' => 3, 'available_count' => 5, 'image' => 'rooms/skylight/executive_suite.jpg'],

            // Hyatt Regency (id=2)
            ['hotel_id' => 2, 'room_type' => 'Standard Room', 'description' => 'Modern room with workspace', 'price_per_night' => 4500.00, 'capacity' => 2, 'available_count' => 25, 'image' => 'rooms/hyatt/standard_room.jpg'],
            ['hotel_id' => 2, 'room_type' => 'Presidential Suite', 'description' => 'Ultimate luxury with butler service', 'price_per_night' => 30000.00, 'capacity' => 4, 'available_count' => 2, 'image' => 'rooms/hyatt/presidential_suite.jpg'],

            // Radisson Blu (id=3)
            ['hotel_id' => 3, 'room_type' => 'Business Class Room', 'description' => 'Room with ergonomic workspace', 'price_per_night' => 6500.00, 'capacity' => 2, 'available_count' => 12, 'image' => 'rooms/radisson/business_class_room.jpg'],
            ['hotel_id' => 3, 'room_type' => 'Family Suite', 'description' => 'Large suite with multiple beds', 'price_per_night' => 18000.00, 'capacity' => 5, 'available_count' => 3, 'image' => 'rooms/radisson/family_suite.jpg'],

            // Hilton (id=4)
            ['hotel_id' => 4, 'room_type' => 'Standard Room', 'description' => 'Comfortable room with garden view', 'price_per_night' => 3800.00, 'capacity' => 2, 'available_count' => 15, 'image' => 'rooms/hilton/standard_room.jpg'],
            ['hotel_id' => 4, 'room_type' => 'Deluxe Room', 'description' => 'Spacious room with premium amenities', 'price_per_night' => 6000.00, 'capacity' => 2, 'available_count' => 10, 'image' => 'rooms/hilton/deluxe_room.jpg'],
            ['hotel_id' => 4, 'room_type' => 'Executive Suite', 'description' => 'Suite with separate living area', 'price_per_night' => 13000.00, 'capacity' => 3, 'available_count' => 5, 'image' => 'rooms/hilton/executive_suite.jpg'],

            // Capital Hotel (id=5)
            ['hotel_id' => 5, 'room_type' => 'Standard Room', 'description' => 'Modern room with city view', 'price_per_night' => 3200.00, 'capacity' => 2, 'available_count' => 20, 'image' => 'rooms/capital/standard_room.jpg'],
            ['hotel_id' => 5, 'room_type' => 'Deluxe Room', 'description' => 'Upgraded room with spa access', 'price_per_night' => 5500.00, 'capacity' => 2, 'available_count' => 12, 'image' => 'rooms/capital/deluxe_room.jpg'],
            ['hotel_id' => 5, 'room_type' => 'Executive Suite', 'description' => 'Suite with business lounge access', 'price_per_night' => 11000.00, 'capacity' => 3, 'available_count' => 4, 'image' => 'rooms/capital/suite.jpg'],

            // Golden Tulip (id=6)
            ['hotel_id' => 6, 'room_type' => 'Standard Room', 'description' => 'Contemporary room with workspace', 'price_per_night' => 3500.00, 'capacity' => 2, 'available_count' => 18, 'image' => 'rooms/golden_tulip/standard_room.jpg'],
            ['hotel_id' => 6, 'room_type' => 'Superior Room', 'description' => 'Larger room with premium bedding', 'price_per_night' => 5000.00, 'capacity' => 2, 'available_count' => 10, 'image' => 'rooms/golden_tulip/deluxe_room.jpg'],
            ['hotel_id' => 6, 'room_type' => 'Executive Suite', 'description' => 'Suite with lounge access', 'price_per_night' => 10000.00, 'capacity' => 3, 'available_count' => 5, 'image' => 'rooms/golden_tulip/suite.jpg'],

            // Best Western (id=7)
            ['hotel_id' => 7, 'room_type' => 'Standard Room', 'description' => 'Comfortable room with basic amenities', 'price_per_night' => 2800.00, 'capacity' => 2, 'available_count' => 25, 'image' => 'rooms/best_western/standard_room.jpg'],
            ['hotel_id' => 7, 'room_type' => 'Deluxe Room', 'description' => 'Upgraded room with sitting area', 'price_per_night' => 4500.00, 'capacity' => 2, 'available_count' => 15, 'image' => 'rooms/best_western/deluxe_room.jpg'],
            ['hotel_id' => 7, 'room_type' => 'Family Room', 'description' => 'Large room with multiple beds', 'price_per_night' => 6000.00, 'capacity' => 4, 'available_count' => 8, 'image' => 'rooms/best_western/suite.jpg'],
        ];

        $this->db->table('rooms')->insertBatch($data);
    }
}
