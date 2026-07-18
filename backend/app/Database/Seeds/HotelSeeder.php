<?php

namespace App\Database\Seeds;

use CodeIgniter\Database\Seeder;

class HotelSeeder extends Seeder
{
    public function run()
    {
        $data = [
            [
                'name'        => 'Ethiopian Skylight Hotel',
                'description' => 'Premium airport hotel with modern amenities',
                'star_rating' => 5,
                'address'     => 'Bole International Airport',
                'city'        => 'Addis Ababa',
                'cover_image' => 'hotels/skylight/cover.jpg',
            ],
            [
                'name'        => 'Hyatt Regency Addis Ababa',
                'description' => 'Luxury business hotel in Kazanchis',
                'star_rating' => 5,
                'address'     => 'Kazanchis',
                'city'        => 'Addis Ababa',
                'cover_image' => 'hotels/hyatt/cover.jpg',
            ],
            [
                'name'        => 'Radisson Blu Addis Ababa',
                'description' => 'Premium business hotel with city views',
                'star_rating' => 4,
                'address'     => 'Kazanchis',
                'city'        => 'Addis Ababa',
                'cover_image' => 'hotels/radisson/cover.jpg',
            ],
            [
                'name'        => 'Hilton Addis Ababa',
                'description' => 'Historic hotel with lush gardens, multiple restaurants, pool, and conference facilities near the city center.',
                'star_rating' => 4,
                'address'     => 'Menelik II Avenue',
                'city'        => 'Addis Ababa',
                'cover_image' => 'hotels/hilton/cover.jpg',
            ],
            [
                'name'        => 'Capital Hotel & Spa',
                'description' => 'Modern hotel with spa facilities, rooftop restaurant, and business center in the Bole district.',
                'star_rating' => 4,
                'address'     => 'Bole',
                'city'        => 'Addis Ababa',
                'cover_image' => 'hotels/capital/cover.jpg',
            ],
            [
                'name'        => 'Golden Tulip Addis Ababa',
                'description' => 'Contemporary hotel with modern amenities, restaurant, fitness center, and convenient airport access.',
                'star_rating' => 4,
                'address'     => 'Bole',
                'city'        => 'Addis Ababa',
                'cover_image' => 'hotels/golden_tulip/cover.jpg',
            ],
            [
                'name'        => 'Best Western Plus Addis Ababa',
                'description' => 'Reliable mid-range hotel with comfortable rooms, restaurant, and business facilities near the airport.',
                'star_rating' => 3,
                'address'     => 'Bole',
                'city'        => 'Addis Ababa',
                'cover_image' => 'hotels/best_western/cover.jpg',
            ],
        ];

        $this->db->table('hotels')->insertBatch($data);
    }
}
