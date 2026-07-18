<?php

namespace App\Database\Seeds;

use CodeIgniter\Database\Seeder;

class HotelImageSeeder extends Seeder
{
    public function run()
    {
        $data = [
            // Skylight Hotel (id=1)
            ['hotel_id' => 1, 'image_path' => 'hotels/skylight/cover.jpg', 'caption' => 'Hotel Exterior', 'sort_order' => 1],
            ['hotel_id' => 1, 'image_path' => 'hotels/skylight/exterior_day.jpg', 'caption' => 'Day View', 'sort_order' => 2],
            ['hotel_id' => 1, 'image_path' => 'hotels/skylight/exterior_night.jpg', 'caption' => 'Night View', 'sort_order' => 3],
            ['hotel_id' => 1, 'image_path' => 'hotels/skylight/lobby.jpg', 'caption' => 'Grand Lobby', 'sort_order' => 4],
            ['hotel_id' => 1, 'image_path' => 'hotels/skylight/pool.jpg', 'caption' => 'Swimming Pool', 'sort_order' => 5],
            ['hotel_id' => 1, 'image_path' => 'hotels/skylight/restaurant.jpg', 'caption' => 'Restaurant', 'sort_order' => 6],
            ['hotel_id' => 1, 'image_path' => 'hotels/skylight/view.jpg', 'caption' => 'City View', 'sort_order' => 7],

            // Hyatt Regency (id=2)
            ['hotel_id' => 2, 'image_path' => 'hotels/hyatt/cover.jpg', 'caption' => 'Hotel Exterior', 'sort_order' => 1],
            ['hotel_id' => 2, 'image_path' => 'hotels/hyatt/exterior_day.jpg', 'caption' => 'Day View', 'sort_order' => 2],
            ['hotel_id' => 2, 'image_path' => 'hotels/hyatt/exterior_night.jpg', 'caption' => 'Night View', 'sort_order' => 3],
            ['hotel_id' => 2, 'image_path' => 'hotels/hyatt/lobby.jpg', 'caption' => 'Grand Lobby', 'sort_order' => 4],
            ['hotel_id' => 2, 'image_path' => 'hotels/hyatt/pool.jpg', 'caption' => 'Swimming Pool', 'sort_order' => 5],
            ['hotel_id' => 2, 'image_path' => 'hotels/hyatt/restaurant.jpg', 'caption' => 'Restaurant', 'sort_order' => 6],
            ['hotel_id' => 2, 'image_path' => 'hotels/hyatt/view.jpg', 'caption' => 'City View', 'sort_order' => 7],

            // Radisson Blu (id=3)
            ['hotel_id' => 3, 'image_path' => 'hotels/radisson/cover.jpg', 'caption' => 'Hotel Exterior', 'sort_order' => 1],
            ['hotel_id' => 3, 'image_path' => 'hotels/radisson/exterior_day.jpg', 'caption' => 'Day View', 'sort_order' => 2],
            ['hotel_id' => 3, 'image_path' => 'hotels/radisson/exterior_night.jpg', 'caption' => 'Night View', 'sort_order' => 3],
            ['hotel_id' => 3, 'image_path' => 'hotels/radisson/lobby.jpg', 'caption' => 'Grand Lobby', 'sort_order' => 4],
            ['hotel_id' => 3, 'image_path' => 'hotels/radisson/pool.jpg', 'caption' => 'Swimming Pool', 'sort_order' => 5],
            ['hotel_id' => 3, 'image_path' => 'hotels/radisson/restaurant.jpg', 'caption' => 'Restaurant', 'sort_order' => 6],
            ['hotel_id' => 3, 'image_path' => 'hotels/radisson/view.jpg', 'caption' => 'City View', 'sort_order' => 7],

            // Hilton (id=4)
            ['hotel_id' => 4, 'image_path' => 'hotels/hilton/cover.jpg', 'caption' => 'Hotel Exterior', 'sort_order' => 1],
            ['hotel_id' => 4, 'image_path' => 'hotels/hilton/exterior.jpg', 'caption' => 'Exterior View', 'sort_order' => 2],
            ['hotel_id' => 4, 'image_path' => 'hotels/hilton/lobby.jpg', 'caption' => 'Lobby', 'sort_order' => 3],
            ['hotel_id' => 4, 'image_path' => 'hotels/hilton/pool.jpg', 'caption' => 'Swimming Pool', 'sort_order' => 4],

            // Capital Hotel (id=5)
            ['hotel_id' => 5, 'image_path' => 'hotels/capital/cover.jpg', 'caption' => 'Hotel Exterior', 'sort_order' => 1],
            ['hotel_id' => 5, 'image_path' => 'hotels/capital/exterior.jpg', 'caption' => 'Exterior View', 'sort_order' => 2],
            ['hotel_id' => 5, 'image_path' => 'hotels/capital/lobby.jpg', 'caption' => 'Lobby', 'sort_order' => 3],
            ['hotel_id' => 5, 'image_path' => 'hotels/capital/restaurant.jpg', 'caption' => 'Restaurant', 'sort_order' => 4],

            // Golden Tulip (id=6)
            ['hotel_id' => 6, 'image_path' => 'hotels/golden_tulip/cover.jpg', 'caption' => 'Hotel Exterior', 'sort_order' => 1],
            ['hotel_id' => 6, 'image_path' => 'hotels/golden_tulip/exterior.jpg', 'caption' => 'Exterior View', 'sort_order' => 2],
            ['hotel_id' => 6, 'image_path' => 'hotels/golden_tulip/lobby.jpg', 'caption' => 'Lobby', 'sort_order' => 3],
            ['hotel_id' => 6, 'image_path' => 'hotels/golden_tulip/restaurant.jpg', 'caption' => 'Restaurant', 'sort_order' => 4],

            // Best Western (id=7)
            ['hotel_id' => 7, 'image_path' => 'hotels/best_western/cover.jpg', 'caption' => 'Hotel Exterior', 'sort_order' => 1],
            ['hotel_id' => 7, 'image_path' => 'hotels/best_western/exterior.jpg', 'caption' => 'Exterior View', 'sort_order' => 2],
            ['hotel_id' => 7, 'image_path' => 'hotels/best_western/lobby.jpg', 'caption' => 'Lobby', 'sort_order' => 3],
            ['hotel_id' => 7, 'image_path' => 'hotels/best_western/restaurant.jpg', 'caption' => 'Restaurant', 'sort_order' => 4],
        ];

        $this->db->table('hotel_images')->insertBatch($data);
    }
}
